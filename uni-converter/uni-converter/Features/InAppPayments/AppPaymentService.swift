//
//  AppPaymentService.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/5/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import RevenueCat
import Foundation
import OSLog

@Observable
class AppPaymentService {
  var totalTipped: Double
  var isSubscribed: Bool
  var isConfigured: Bool = false

  var numberOfCoffees: Int {
    Int((totalTipped/4.99).rounded(.down))
  }
  var formattedTotalTipped: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter.string(from: NSNumber(value: totalTipped)) ?? "$0.00"
  }

  init(totalTipped: Double = 0.0, isSubscribed: Bool = false) {
    self.totalTipped = totalTipped
    self.isSubscribed = isSubscribed
  }
  
  /// Configure RevenueCat
  func configure() {
    let handler: (RevenueCat.LogLevel, String) -> Void = { level, message in
      switch level {
        case .debug:
          Logger.purchases.debug("\(message)")
        case .verbose:
          Logger.purchases.trace("\(message)")
        case .info:
          Logger.purchases.info("\(message)")
        case .warn:
          Logger.purchases.warning("\(message)")
        case .error:
          Logger.purchases.error("\(message)")
      }
    }
    Purchases.logHandler = handler
#if DEBUG
    Purchases.logLevel = .debug
#else
    Purchases.logLevel = .error
#endif
    Purchases.configure(withAPIKey: AppInfo.revenueCatKey)
    isConfigured = true
    Task {
      for await newCustomerInfo in Purchases.shared.customerInfoStream {
        // Update total tipped amount whenever customer info changes
        await updateTotalTipped(with: newCustomerInfo)

        // Update subscription status
        await updateSubscriptionStatus(with: newCustomerInfo)

        await MainActor.run {
          Logger.appPaymentService.info(
            """
            💸 Customer Info updated: Total tipped: $\(self.totalTipped)
            """
          )
        }
      }
    }
  }

  // MARK: - Total Calculation

  /// Updates the total tipped amount by combining one-time purchases and subscription spending
  /// - Parameter customerInfo: The customer info from RevenueCat (typically from customerInfoStream)
  func updateTotalTipped(with customerInfo: CustomerInfo) async {
    // Calculate the total from one-time tip purchases
    let oneTimePurchases = await calculateOneTimePurchases(from: customerInfo)

    // Calculate the total spent on subscriptions over all billing periods
    let subscriptionSpend = await calculateSubscriptionSpend(from: customerInfo)

    // Update the published property on the main thread
    await MainActor.run {
      self.totalTipped = oneTimePurchases + subscriptionSpend
    }
  }

  /// Updates the subscription status based on active subscriptions
  /// - Parameter customerInfo: The customer info from RevenueCat
  func updateSubscriptionStatus(with customerInfo: CustomerInfo) async {
    // Check if the user has any active subscriptions
    let hasActiveSubscription = !customerInfo.activeSubscriptions.isEmpty

    await MainActor.run {
      self.isSubscribed = hasActiveSubscription
    }
  }

  // MARK: - One-Time Purchases

  /// Calculates the total amount spent on one-time tip purchases (non-subscription)
  /// - Parameter customerInfo: The customer info containing transaction history
  /// - Returns: The sum of all one-time purchase prices
  private func calculateOneTimePurchases(from customerInfo: CustomerInfo) async -> Double {
    // Get all non-subscription transactions (one-time tips)
    let transactions = customerInfo.nonSubscriptions

    guard !transactions.isEmpty else { return 0.0 }

    // Get product IDs from transactions to fetch pricing
    let productIDs = transactions.map { $0.productIdentifier }
    let products = await Purchases.shared.products(productIDs)

    // Sum up the prices of all one-time purchases
    var total = 0.0
    for transaction in transactions {
      if let product = products.first(where: { $0.productIdentifier == transaction.productIdentifier }) {
        // Convert Decimal to Double for calculation
        total += NSDecimalNumber(decimal: product.price).doubleValue
      }
    }

    return total
  }

  // MARK: - Subscription Spend

  /// Calculates the total amount spent on subscriptions across all billing periods
  /// - Parameter customerInfo: The customer info containing entitlement history
  /// - Returns: The sum of subscription prices multiplied by the number of billing periods elapsed
  private func calculateSubscriptionSpend(from customerInfo: CustomerInfo) async -> Double {
    var total = 0.0

    // Loop through all entitlements (active and expired subscriptions)
    for (_, entitlement) in customerInfo.entitlements.all {
      // Need the original purchase date to calculate how many billing periods have elapsed
      guard let originalPurchaseDate = entitlement.originalPurchaseDate else { continue }

      // Fetch the product to get pricing and subscription period
      let products = await Purchases.shared.products([entitlement.productIdentifier])
      guard let product = products.first else { continue }

      // Calculate how many billing periods (months, years, etc.) have passed
      let billingPeriods = calculateBillingPeriods(
        from: originalPurchaseDate,
        to: Date(),
        period: product.subscriptionPeriod
      )

      // Total = price per period × number of periods
      total += NSDecimalNumber(decimal: product.price).doubleValue * Double(billingPeriods)
    }

    return total
  }

  /// Calculates the number of billing periods that have elapsed between two dates
  /// - Parameters:
  ///   - start: The original purchase date
  ///   - end: The current date (or end date)
  ///   - period: The subscription period (e.g., 1 month, 1 year)
  /// - Returns: The number of complete billing periods, minimum of 1
  private func calculateBillingPeriods(from start: Date, to end: Date, period: RevenueCat.SubscriptionPeriod?) -> Int {
    guard let period = period else { return 1 }

    let calendar = Calendar.current
    let periodValue = period.value

    // Calculate elapsed periods based on the subscription's billing unit
    switch period.unit {
    case .month:
      // Calculate months between dates and divide by period value (e.g., if period is 2 months)
      let months = calendar.dateComponents([.month], from: start, to: end).month ?? 0
      return max(1, months / periodValue)
    case .year:
      let years = calendar.dateComponents([.year], from: start, to: end).year ?? 0
      return max(1, years / periodValue)
    case .week:
      let weeks = calendar.dateComponents([.weekOfYear], from: start, to: end).weekOfYear ?? 0
      return max(1, weeks / periodValue)
    case .day:
      let days = calendar.dateComponents([.day], from: start, to: end).day ?? 0
      return max(1, days / periodValue)
    @unknown default:
      return 1
    }
  }
}
