//
//  UniConverterApp.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/4/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import SwiftUI
import RevenueCat

@main
struct UniConverterApp: App {
  @Environment(\.scenePhase) var scenePhase
  @StateObject private var settingsManager = SettingsManager()
  
  let persistenceController = PersistenceController()
  
  init() {
    
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(
          \.managedObjectContext,
           persistenceController.viewContext
        )
        .environmentObject(settingsManager)
        .environmentObject(
          CalculationManager(
            mc: persistenceController.viewContext,
            settings: settingsManager
          )
        )
    }
    .onChange(of: scenePhase) {
      persistenceController.save()
    }
  }
}
