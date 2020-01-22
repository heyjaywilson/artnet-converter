//
//  CalculationRowView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct CalculationRowView: View {
  @EnvironmentObject var calcManager: CalculationManager
  @EnvironmentObject var settingsManager: SettingsManager
  
  @State private var sub: String = ""
  @State private var uni: String = ""
  
  var calc: CalcEntity
  @Binding var display: Bool
  @Binding var calcAddNote: CalcEntity
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
            Text(sub)
              .fontWeight(.bold)
              .foregroundColor(self.determineFontColor(calc.isZeroArt))
          }.padding(.horizontal)
          VStack{
            Text("uni")
              .font(.subheadline)
              .foregroundColor(.gray)
              .multilineTextAlignment(.center)
            Text(uni)
              .fontWeight(.bold)
              .foregroundColor(self.determineFontColor(calc.isZeroArt))
          }
        }
      }.onAppear{
        self.getAnswers()
      }
    }
    .contextMenu{
      Button(action: {
        print("delete")
        self.calcManager.deleteCalc(self.calc)
      }) {
        Text("Delete")
        Image(systemName: "trash")
      }
      Button(action: {
        self.display.toggle()
        self.calcAddNote = self.calc
      }) {
        Text("Add Note")
        Image(systemName: "plus.app")
      }
    }
  }
  func getAnswers(){
    if settingsManager.showHex {
      sub = getHex(num: Int(calc.subnet))
      uni = getHex(num: Int(calc.artuni))
    } else {
      sub = "\(calc.subnet)"
      uni = "\(calc.artuni)"
    }
  }
  
  func getHex(num: Int) -> String {
    let hexValue = String(format:"%0X", num)
    return hexValue
  }
  func determineFontColor(_ yayOrNay: Bool) -> Color {
    if yayOrNay{
      return Color.red
    } else {
      return Color.blue
    }
  }
}
