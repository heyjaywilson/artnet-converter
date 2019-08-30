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
            }.padding(.horizontal)
            HStack{
                NumberButton(num: 7)
                NumberButton(num: 8)
                NumberButton(num: 9)
            }
            HStack{
                NumberButton(num: 4)
                NumberButton(num: 5)
                NumberButton(num: 6)
            }
            HStack{
                NumberButton(num: 1)
                NumberButton(num: 2)
                NumberButton(num: 3)
            }
            HStack{
                NumberButton(num: 0).padding(.leading, 0.2)
                Spacer()
                Button(action: {
                    print("calculate")
                }){
                    Text("Calculate")
                        .font(.title)
                        .foregroundColor(Color.red)
                        .padding(.all, 20.0)
                        .background(Color.black)
                        .cornerRadius(2.0)
                }.padding(.trailing)
            }
        }
    }
}

struct AllButtons_Previews: PreviewProvider {
    static var previews: some View {
        AllButtons()
    }
}
