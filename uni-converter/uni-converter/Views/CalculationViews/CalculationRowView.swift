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
        HStack(alignment: .center){
            VStack{
                Text("uni")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                Text("\(calc.priuni)")
                    .font(.title)
                    .foregroundColor(self.determineFontColor(calc.isZeroUni))
            }
            Spacer()
            VStack{
                Text("ArtNet")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(0)
                HStack{
                    VStack{
                        Text("sub")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(calc.subnet)")
                            .fontWeight(.bold)
                            .foregroundColor(self.determineFontColor(calc.isZeroArt))
                    }.padding(.horizontal)
                    VStack{
                        Text("uni")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Text("\(calc.artuni)")
                            .fontWeight(.bold)
                            .foregroundColor(self.determineFontColor(calc.isZeroArt))
                    }
                }
            }
        }
    }
    
    func determineFontColor(_ yayOrNay: Bool) -> Color {
        if yayOrNay{
            return Color.red
        } else {
            return Color.blue
        }
    }
}

//struct CalculationRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculationRowView()
//    }
//}
