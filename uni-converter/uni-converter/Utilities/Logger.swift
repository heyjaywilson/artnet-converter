//
//  Logger.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/5/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import Foundation
import OSLog

enum LogCategory: String {
  case `default`
  case purchases
  case appPaymentService
}

extension Logger {
  static let appPaymentService = Logger(
    subsystem: AppInfo.subsystem,
    category: LogCategory.appPaymentService.rawValue
  )
  static let purchases = Logger(
    subsystem: AppInfo.subsystem,
    category: LogCategory.purchases.rawValue
  )
}
