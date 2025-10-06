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
  
  init(totalTipped: Double = 0.0) {
    self.totalTipped = totalTipped
  }
  
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
    Task {
      for await newCustomerInfo in Purchases.shared.customerInfoStream {
        await MainActor.run {
          Logger.appPaymentService.info(
            """
            💸 Customer Info updated:
            """
          )
        }
      }
    }
  }
}
