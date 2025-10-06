//
//  ProductRow.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/6/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
  var tipOption: TipOption
  
  var body: some View {
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
//    ProductRow(
//      icon: .lightbulbMinFill,
//      headline: "Monthly",
//      bodyText: "Monthly support that keeps things running smoothly.",
//      priceString: "$10.99",
//      textColor: .white,
//      gradientColors: [Color(red: 0.369, green: 0.361, blue: 0.902), Color(red: 0.0, green: 0.478, blue: 1.0)]
//    )
//    Section {
//      ProductRow(
//        icon: .lightbulbMinFill,
//        headline: "Monthly",
//        bodyText: "This is some text to get you to upgrade",
//        priceString: "$10.99",
//        gradientColors: colorScheme == .light ? [.white] : [.black]
//      )
//    }
  }
}
