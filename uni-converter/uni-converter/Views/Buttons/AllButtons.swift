//
//  AllButtons.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct AllButtons: View {
    @EnvironmentObject var calcManager: CalculationManager
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.calcManager.deleteNumberFromPrimUni()
                }){
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                }
                .frame(width: 40.0, height: 40.0)
                .padding(.all, 15.0)
                Spacer()
                Button(action: {
                    print("P -> A")
                }){
                    Text("Uni -> ArtNet")
                }
            }
            Spacer()
            HStack{
                NumberButton(num: 7)
                Spacer()
                NumberButton(num: 8)
                Spacer()
                NumberButton(num: 9)
            }
            Spacer()
            HStack{
                NumberButton(num: 4)
                Spacer()
                NumberButton(num: 5)
                Spacer()
                NumberButton(num: 6)
            }
            Spacer()
            HStack{
                NumberButton(num: 1)
                Spacer()
                NumberButton(num: 2)
                Spacer()
                NumberButton(num: 3)
            }
            Spacer()
            HStack{
                NumberButton(num: 0)
                Spacer()
                Button(action: {
                    print("calculate")
                }){
                    Text("Calculate")
                        .font(.title)
                        .foregroundColor(Color.red)
                        .padding(.trailing)
                }
            }
        }
    }
}

struct AllButtons_Previews: PreviewProvider {
    static var previews: some View {
        AllButtons()
    }
}
