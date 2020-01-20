//
//  CalculateView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//
import Foundation
import SwiftUI

struct CalculateView: View {
  @EnvironmentObject var calcManager: CalculationManager
  @EnvironmentObject var settingsManager: SettingsManager
  
  @State private var isHexShown = false
  var body: some View {
    VStack {
      HStack {
        UniverseView(uni: calcManager.prim_uni)
        Spacer()
        Group{
          if isHexShown {
            Text(showHex())
          } else {
            SubView(sub: calcManager.subnet)
              .padding(.trailing)
            UniverseView(uni: calcManager.art_uni)
          }
        }.onTapGesture {
          self.isHexShown.toggle()
        }
      }
      .padding(.horizontal)
      .padding(.top, 50)
      Spacer()
      AllButtons()
        .padding(.bottom, 50)
    }.onAppear{
      if self.calcManager.prim_uni <= 1 {
        self.calcManager.setNum(art: self.settingsManager.returnZeroOrOne(self.settingsManager.zeroArt))
        self.calcManager.setNum(primUni: self.settingsManager.returnZeroOrOne(self.settingsManager.zeroUni))
      }
    }
  }
  
  func showHex() -> String{
    let st = String(format:"%02X", calcManager.prim_uni)
    print(st)
    return st
  }
}
