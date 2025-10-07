//
//  TipJarView.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/6/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct TipJarView: View {
  @Environment(AppPaymentService.self) var appPaymentService

  @State private var packages: [String: Package] = [:]
  @State private var showTipInCoffees = false
  @State private var showCustomerCenter = false
  
  var body: some View {
    List {
      Section {
        HStack(alignment: .top, spacing: 16) {
          Image("jaywilson")
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
          Text("""
Hey there! My name is **Jay**, and I love making apps. Universe Converter is one of the first apps I made to convert the numbers on ArtNet nodes to the numbers that consoles need.
If you've found any value in Universe Converter, then consider tossing a tip my way and make my day.
""")
          .fontDesign(.rounded)
        }
      }
      if appPaymentService.totalTipped > 0 {
        Section {
          VStack {
            Text(showTipInCoffees ? "Coffees you have purchased for Jay" : "Your Total Contributions")
              .font(.subheadline)
              .foregroundStyle(.secondary)
            HStack(alignment: .lastTextBaseline) {
              Text(showTipInCoffees ? "\(appPaymentService.numberOfCoffees) ☕" : appPaymentService.formattedTotalTipped)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(showTipInCoffees ? Color.primary : Color.accentColor)
            }
          }
          .frame(maxWidth: .infinity)
          .onTapGesture {
              showTipInCoffees.toggle()
          }
        }
      }
      if let package = packages[TipProduct.monthly.rawValue] {
        if appPaymentService.isSubscribed == false {
          Section("Monthly Support") {
            ProductRow(
              tipOption: TipOption(
                icon: "✨",
                name: "Monthly Supporter",
                price: package.localizedPriceString,
                description: "Monthly support that keeps things running smoothly.",
                isMonthly: true,
                gradientColors: [Color(red: 0.369, green: 0.361, blue: 0.902), Color(red: 0.0, green: 0.478, blue: 1.0)]
              ),
              package: package
            )
          }
        }
      }
      Section("One-Time Tips") {
        if let package = packages[TipProduct.tier1.rawValue] {
          ProductRow(
            tipOption: TipOption(
              icon: "🍬",
              name: "Sweet Treat",
              price: package.localizedPriceString,
              description: "Small but appreciated, thank you.",
              isMonthly: false
            ),
            package: package
          )
        }
        if let package = packages[TipProduct.tier3.rawValue] {
          ProductRow(
            tipOption: TipOption(
              icon: "☕",
              name: "Coffee Break",
              price: package.localizedPriceString,
              description: "This makes a real difference, appreciate it.",
              isMonthly: false
            ),
            package: package
          )
        }
        if let package = packages[TipProduct.tier4.rawValue] {
          ProductRow(
            tipOption: TipOption(
              icon: "🍕",
              name: "Meal time",
              price: package.localizedPriceString,
              description: "Wow, this is incredibly generous. Thank you.",
              isMonthly: false
            ),
            package: package
          )
        }
      }
      Section {
        Button("Need help?") {
          showCustomerCenter.toggle()
        }
        .sheet(isPresented: $showCustomerCenter) {
          CustomerCenterView()
        }
      }
    }
    .navigationTitle("💡 Support this app")
    .fontDesign(.rounded)
    .task {
      if appPaymentService.isConfigured {
        await fetchProducts()
      }
    }
  }
  
  func fetchProducts() async {
    do {
      let offerings = try await Purchases.shared.offerings()
      if let offering = offerings.current {
        for package in offering.availablePackages {
          packages[package.identifier] = package
        }
      }
    } catch {
      print(error)
    }
  }
  
}

#Preview("Not subscribed no tips") {
  @Previewable @State var appPaymentService = AppPaymentService()
  NavigationStack {
    TipJarView()
  }
  .task {
    appPaymentService.configure()
  }
  .environment(appPaymentService)
}


#Preview("Subscribed with 1 tip") {
  @Previewable @State var appPaymentService = AppPaymentService(
    totalTipped: 0.99,
    isSubscribed: true
  )
  NavigationStack {
    TipJarView()
  }
  .environment(appPaymentService)
}


#Preview("Subscribed with 12 tips") {
  @Previewable @State var appPaymentService = AppPaymentService(
    totalTipped: 11.88,
    isSubscribed: true
  )
  NavigationStack {
    TipJarView()
  }
  .environment(appPaymentService)
}
