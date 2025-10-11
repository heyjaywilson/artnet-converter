//
//  UniConverterApp.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/4/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import SwiftUI
import RevenueCat
import Factory

@main
struct UniConverterApp: App {
    @Injected(\.analytics) private var analytics
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var paymentService = AppPaymentService()
    @StateObject private var settingsManager = SettingsManager()
    
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(paymentService)
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
                .task {
                    paymentService.configure()
                }
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
