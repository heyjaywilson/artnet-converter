//
//  Signal.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/10/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//


enum Signal: String {
    case buttonTapped = "Button.Tapped"
    case paywallViewed = "Paywall.Viewed"
    case purchaseCompleted = "Purchase.completed"
    case purchaseCancelled = "Purchase.Cancelled"
}

enum SignalParameter: String {
    case source
    case purchaseType = "Purchase.type"
    case purchaseCountryCode = "Purchase.countryCode"
    case purchasecurrencyCode = "Purchase.currencyCode"
    case package = "Purchase.package"
    case price = "Package.price"
}

enum PurchaseType: String {
    case subscription
    case oneTime = "one-time-purchase"
}
