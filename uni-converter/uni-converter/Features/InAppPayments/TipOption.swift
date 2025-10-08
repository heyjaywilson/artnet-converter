//
//  PackageHelper.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/6/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import SwiftUI

enum TipProduct: String {
  case monthly = "$rc_monthly"
  case tier1 = "tier.1"
  case tier2 = "tier.2"
  case tier3 = "tier.3"
  case tier4 = "tier.4"
}

struct TipOption {
  let icon: String
  let name: LocalizedStringKey
  let price: String
  let description: LocalizedStringKey
  let isMonthly: Bool
  var gradientColors: [Color]? = nil
}
