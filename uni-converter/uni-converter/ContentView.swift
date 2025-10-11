//
//  ContentView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import StoreKit
import RevenueCatUI
import Factory

struct ContentView: View {
    @Injected(\.analytics) var analytics
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(AppPaymentService.self) var paymentService
    
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
                    Settings()
                        .environmentObject(settingsManager)
                        .environment(paymentService)
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
                    
                    Settings()
                        .environmentObject(settingsManager)
                        .environment(paymentService)
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
            TipJarView()
                .environment(paymentService)
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
            
            if totalLaunched > 5 && totalLaunched % 5 == 0 {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    AppStore.requestReview(in: scene)
                }
            }
            
            if totalLaunched % 10 == 0 && showUpdate == false {
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
