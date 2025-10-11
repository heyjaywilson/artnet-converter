//
//  AnalyticsService.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/10/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import Foundation

protocol AnalyticsService {
    func track(event: Signal, parameters: [SignalParameter: String])
    func trackPurchase(
        purchaseType: PurchaseType,
        currencyCode: String,
        countryCode: String,
        package: String,
        value: NSDecimalNumber
    )
}
