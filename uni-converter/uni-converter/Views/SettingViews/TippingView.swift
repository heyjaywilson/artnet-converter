//
//  TippingView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/10/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import StoreKit
struct TippingView: View {
    @State private var products: [SKProduct] = []
    
    var store = ArtnetAppProducts.store
    
    var body: some View {
        VStack{
            Text("If you enjoy using the app, please consider giving Maegan a tip using an in-app purchase. Your support is greatly appreciated.")
            List{
                ForEach(self.products, id: \.productIdentifier){ product in
                    TippingRow(product: product)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarTitle("👍 Tips")
        .navigationBarItems(trailing: Button(action: {
            self.store.restorePurchases()
        }, label: {
            Text("Restore Purchases")
        }))
        .onAppear{
            self.store.requestProducts { (success, products) in
                if success {
                    self.products = products!
                }
            }
        }
    }
}

struct TippingView_Previews: PreviewProvider {
    static var previews: some View {
        TippingView()
    }
}
