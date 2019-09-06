//
//  CalculateView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct CalculateView: View {
    @EnvironmentObject var calcManager: CalculationManager
    
    var body: some View {
        VStack {
            HStack {
                UniverseView(uni: calcManager.prim_uni)
                Spacer()
                SubView(sub: calcManager.subnet)
                    .padding(.trailing)
                UniverseView(uni: calcManager.art_uni)
            }.padding(.horizontal)
            AllButtons()
        }
    }
}
