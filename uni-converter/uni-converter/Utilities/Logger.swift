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
    case analytics
}

extension Logger {
    static let appPaymentService = Logger(
        subsystem: AppInfo.bundleId,
        category: LogCategory.appPaymentService.rawValue
    )
    
    static let purchases = Logger(
        subsystem: AppInfo.bundleId,
        category: LogCategory.purchases.rawValue
    )
    
    static let analytics = Logger(
        subsystem: AppInfo.bundleId,
        category: LogCategory.analytics.rawValue
    )
}
