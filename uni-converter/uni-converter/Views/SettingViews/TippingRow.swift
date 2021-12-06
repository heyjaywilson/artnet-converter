//
//  TippingRow.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/10/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import StoreKit
import Purchases

struct TippingRow: View {
    @ObservedObject var settings = UserSettings()
    var product: SKProduct
    
    @Binding var totalTipped: Double
    @Binding var formattedTip: String
    
    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var body: some View {
        HStack{
            Text("\(self.getEmoji())")
            Spacer()
            Button(action: {
                print("Buy")
                Purchases.shared.purchaseProduct(product) { (transaction, purchaserInfo, error, userCancelled) in
                    
                    guard let purchase = transaction else {
                        print(error!)
                        return
                    }
                    print("🧑‍💻 \(purchase)")
                    totalTipped += Double(truncating: product.price)
                    
                    let currencyFormatter = NumberFormatter()
                    currencyFormatter.usesGroupingSeparator = true
                    currencyFormatter.numberStyle = .currency
                    currencyFormatter.locale = Locale.current
                    
                    let amount = currencyFormatter.string(from: NSNumber(value: totalTipped))!
                    
                    formattedTip = amount
                    
                }
            }){
                Text("\(TippingRow.priceFormatter.string(from: self.product.price) ?? "--")")
                    .padding(.all, 8)
                    .foregroundColor(.white)
                    .background(Color.green)
                .cornerRadius(10)
            }
        }
    }
    
    func getEmoji() -> String {
        switch product.localizedTitle{
            case "Tip - Smiles":
                return "Thanks for making Maegan smile 😊"
            case "Tip - buy a coffee for Maegan":
                return "Thank you for my cup of coffee ☕"
            case "Tip - hearts":
                return "I ❤️ you for this!!"
            case "Tip - 10 for Maegan":
                return "You are 💯% amazing!"
            default:
                return product.localizedTitle
        }
    }
    
}

//struct TippingRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TippingRow(product: SKProduct())
//    }
//}
