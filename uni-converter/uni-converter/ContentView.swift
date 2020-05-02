//
//  ContentView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import StoreKit

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @EnvironmentObject var calcManager: CalculationManager
  @EnvironmentObject var settingsManager: SettingsManager
  
  @ObservedObject var settings = UserSettings()
  
  @State private var selection = 0
  
  @State private var showUpdate = false
  
  var body: some View {
    Group{
      if settings.isiPad {
        TabView(selection: $selection){
          CalcSavedView()
            .environmentObject(calcManager)
            .environmentObject(settingsManager)
            .tabItem {
              VStack {
                Image(systemName: "square.grid.2x2")
                Text("Calc")
              }
          }
          .tag(0)
          Settings().environmentObject(settingsManager)
            .tabItem {
              VStack {
                Image(systemName: "gear")
                Text("Settings")
              }
          }
          .tag(2)
        }
      } else {
        TabView(selection: $selection){
          CalculateView()
            .environmentObject(calcManager)
            .environmentObject(settingsManager)
            .tabItem {
              VStack {
                Image(systemName: "square.grid.2x2")
                Text("Calc")
              }
          }
          .tag(0)
          
          Favorites()
            .environment(\.managedObjectContext, managedObjectContext)
            .environmentObject(calcManager)
            .tabItem {
              VStack {
                Image(systemName: "heart.circle")
                Text("Saved")
              }
          }
          .tag(1)
          
          Settings().environmentObject(settingsManager)
            .tabItem {
              VStack {
                Image(systemName: "gear")
                Text("Settings")
              }
          }
          .tag(2)
        }
      }
    }
    .sheet(isPresented: $showUpdate){
      TippingView(showUpdate: self.showUpdate)
    }
    .onAppear{
      self.calcManager.getCalcs()
      let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
      print(self.settings.currentVersion)
      print(self.settings.numberTimesLaunched)
      var totalLaunched = self.settings.numberTimesLaunched
      totalLaunched = totalLaunched + 1
      
      if self.settings.currentVersion != appVersion {
        if totalLaunched < 2 {
          self.showUpdate = false
        } else {
          self.showUpdate = true
        }
      }
      
      if totalLaunched > 5 {
        SKStoreReviewController.requestReview()
      }
      
      if totalLaunched % 25 == 0{
        self.showUpdate = true
      } else {
        self.showUpdate = false
      }
      
      print("TotalLaunched = \(totalLaunched)")
      
      self.settings.numberTimesLaunched = totalLaunched
      self.setDevice()
    }

  }
  
  func setDevice(){
    let modelName = UIDevice.modelName
    if modelName.contains("iPad"){
      settings.isiPad = true
    } else {
      settings.isiPad = false
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  @EnvironmentObject var calcManager: CalculationManager
  static var previews: some View {
    ContentView()
  }
}
