//
//  TippingView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/10/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import StoreKit
import Purchases

struct TippingView: View {
  @ObservedObject var settings = UserSettings()
  
  @State private var products: [SKProduct] = []
  @State private var totalTipped: Double = 0.0
  @State private var formatedTip: String = ""
  @State private var showUsingText = false
  
  var store = ArtnetAppProducts.store
  var showUpdate = false
  
  var updateText = "Thanks for updating to the latest version of Universe Converter for ArtNet!"
  
  static let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    
    formatter.formatterBehavior = .behavior10_4
    formatter.numberStyle = .currency
    
    return formatter
  }()
  
  var body: some View {
    VStack{
      if showUpdate{
        Text(updateText)
          .font(.largeTitle)
          .padding(.all)
      } else {
        Text("Thanks for using Universe Converter for ArtNet!")
          .font(.largeTitle)
          .padding(.all)
      }
      Text("The app is free to use and download. It relies on your support to fund further development. If you have found the app useful in any way, please consider leaving a \"tip\".")
      Text("Total Tipped: \(formatedTip)")
      List{
        ForEach(self.products, id: \.productIdentifier){ product in
            TippingRow(product: product, totalTipped: $totalTipped, formattedTip: $formatedTip)
        }
      }
    }
    .padding(.horizontal)
    .navigationBarTitle("👍 Tips")
    .onAppear{
        Purchases.shared.products(["tier1", "tier2", "tier3","tier4"]) { tipLevels in
            products = tipLevels
        }
        Purchases.shared.syncPurchases { purchaseInfo, error in
            guard let info = purchaseInfo else {
                print(error!)
                return
            }
            
            let transactions = info.nonSubscriptionTransactions
            print(transactions)
            for transaction in transactions {
                let productID = transaction.productId
                for product in products {
                    if productID == product.productIdentifier {
                        totalTipped += Double(truncating: product.price)
                    }
                }
            }
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale.current
            
            formatedTip = currencyFormatter.string(from: NSNumber(value: totalTipped))!
        }
    }
  }
}

struct TippingView_Previews: PreviewProvider {
  static var previews: some View {
    TippingView()
  }
}
