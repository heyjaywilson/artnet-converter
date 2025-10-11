//
//  AppInfo.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/5/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//
import Foundation

enum AppInfo {
  static let revenueCatKey = "mygOAyICoRrxHzKBOEFRXLkuAuIVrVnn"
  static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
  /// Current build number of the app
  static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
  /// App's display name
  static let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "Universer Converter"
  static let bundleId = Bundle.main.bundleIdentifier!
}
