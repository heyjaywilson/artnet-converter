//
//  CalculationRowView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct CalculationRowView: View {
    var calc: CalcEntity
    var body: some View {
        HStack{
            VStack{
                Text("Primary Universe")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(calc.priuni)")
            }
            Spacer()
            VStack{
                Text("Subnet")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(calc.subnet)")
            }.padding(.horizontal)
            VStack{
                Text("ArtNet Universe")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(calc.artuni)")
            }
        }
    }
}

//struct CalculationRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculationRowView()
//    }
//}
