//
//  ProductRow.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/6/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import SwiftUI
import RevenueCat
import Factory

struct ProductRow: View {
    @Injected(\.analytics) var analytics
    
    var tipOption: TipOption
    var package: Package? = nil
    
    var body: some View {
        if let package {
            Button {
                purchase(package: package)
            } label: {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(tipOption.icon)
                        Text(tipOption.name)
                        Spacer()
                        Text(tipOption.price)
                            .foregroundStyle(tipOption.isMonthly ? Color.white : .accentColor)
                    }
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    Text(tipOption.description)
                }
                .foregroundStyle(tipOption.isMonthly ? Color.white : .primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .listRowBackground(
                Group {
                    if let colors = tipOption.gradientColors {
                        LinearGradient(
                            colors: colors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    } else {
                        Color(.systemBackground)
                    }
                }
            )
        } else {
            EmptyView()
        }
    }
    
    func purchase(package: Package) {
        Task {
            do {
                let purchase = try await Purchases.shared.purchase(package: package)
                
                if purchase.userCancelled {
                    analytics.track(
                        event: .purchaseCancelled,
                        parameters: [
                            .package: package.identifier,
                            .price: package.storeProduct.price.formatted()
                        ]
                    )
                } else {
                    guard let transaction = purchase.transaction else { return }
                    analytics
                        .trackPurchase(
                            purchaseType: transaction.sk2Transaction?.subscriptionGroupID != nil ? .subscription : .oneTime,
                            currencyCode: transaction.sk2Transaction?.currency?.identifier ?? "???",
                            countryCode: transaction.storefront?.countryCode ?? "???",
                            package: package.identifier,
                            value: NSDecimalNumber(decimal: transaction.sk2Transaction?.price
                                                   ?? 0.0)
                        )
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    
    List {
        ProductRow(
            tipOption: TipOption(
                icon: "💡",
                name: "Monthly supporter",
                price: "$0.99/month",
                description: "Monthly support that keeps things running smoothly",
                isMonthly: true,
                gradientColors: [Color(red: 0.369, green: 0.361, blue: 0.902), Color(red: 0.0, green: 0.478, blue: 1.0)]
            )
        )
        Section {
            ProductRow(
                tipOption: TipOption(
                    icon: "☕",
                    name: "Small Tip",
                    price: "$4.99",
                    description: "Even a little bit of coffee keeps the app being develolped",
                    isMonthly: false,
                    gradientColors: nil
                )
            )
        }
    }
}
