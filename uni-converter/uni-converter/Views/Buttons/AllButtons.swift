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
    
    @State private var toggleSave: Bool = false
    
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
                NumberButton(toggle: self.$toggleSave, num: 7)
                NumberButton(toggle: self.$toggleSave, num: 8)
                NumberButton(toggle: self.$toggleSave, num: 9)
            }
            HStack{
                NumberButton(toggle: self.$toggleSave, num: 4)
                NumberButton(toggle: self.$toggleSave, num: 5)
                NumberButton(toggle: self.$toggleSave, num: 6)
            }
            HStack{
                NumberButton(toggle: self.$toggleSave, num: 1)
                NumberButton(toggle: self.$toggleSave, num: 2)
                NumberButton(toggle: self.$toggleSave, num: 3)
            }
            HStack{
                NumberButton(toggle: self.$toggleSave, num: 0)
                Button(action:
                    {
                        self.toggleSave.toggle()
                        self.toggleSave ? self.calcManager.saveCalculation() : self.calcManager.deleteCalc()
                }){
                    Image(systemName: "\(self.toggleSave ? "heart.fill" : "heart")")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 110, height: 70)
                        .padding(.all, 10.0)
                        .padding(.horizontal, 40.0)
                }
            }.padding(.horizontal)
        }
    }
    
}

struct AllButtons_Previews: PreviewProvider {
    static var previews: some View {
        AllButtons()
    }
}
