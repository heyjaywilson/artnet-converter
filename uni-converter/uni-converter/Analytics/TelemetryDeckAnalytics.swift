//
//  TelemetryDeckAnalytics.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/10/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import Foundation
import TelemetryDeck
import OSLog
import Factory

extension Container {
    var analytics: Factory<AnalyticsService> {
        self {
            TelemetryDeckAnalytics.configure()
            return TelemetryDeckAnalytics()
        }
            .singleton
    }
}


struct TelemetryDeckAnalytics: AnalyticsService {

    static func configure() {
        let appId = "50772017-A8C4-401C-84F0-28E698C16B2D"
        let config = TelemetryDeck.Config(appID: appId)
        
        TelemetryDeck.initialize(config: config)
    }
    
    func track(event: Signal, parameters: [SignalParameter : String] = [:]) {
        let stringParams = parameters.reduce(into: [String: String]()) { result, pair in
            result[pair.key.rawValue] = pair.value
        }
        
        TelemetryDeck.signal(event.rawValue, parameters: stringParams)
        logAnalytics(event: event, parameters: stringParams)
    }
    func trackPurchase(
        purchaseType: PurchaseType,
        currencyCode: String,
        countryCode: String,
        package: String,
        value: NSDecimalNumber
    ) {
        let parameters: [SignalParameter: String] = [
            .purchaseType: purchaseType.rawValue,
            .purchaseCountryCode: countryCode,
            .purchasecurrencyCode: currencyCode,
            .package: package
            ]
        var formattedParameters: [String: String] = parameters.reduce(into: [String: String]()) { result, pair in
            result["TelemetryDeck." + pair.key.rawValue] = pair.value
        }
        
        TelemetryDeck
            .signal(
                "TelemetryDeck." + Signal.purchaseCompleted.rawValue,
                parameters: formattedParameters
            )
        
        formattedParameters["value"] = value.stringValue
        
        logAnalytics(
            event: Signal.purchaseCompleted,
            parameters: formattedParameters
        )
        
    }

    private func logAnalytics(event: Signal, parameters: [String: String]) {
        Logger.analytics.debug("""
            ℹ️ Analytic event: \(event.rawValue, privacy: .public) >> \(parameters.map { "\($0.key):\($0.value)" }.joined(separator: ","))
            """)
    }
}
