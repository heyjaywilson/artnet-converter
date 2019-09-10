//
//  Settings.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("Universe Settings").padding(.top)){
                    Toggle(isOn: $settingsManager.zeroUni) {
                        Text("Primary Universes is \(settingsManager.returnZeroOrOne(self.settingsManager.zeroUni))")
                    }
                    Toggle(isOn: $settingsManager.zeroArt) {
                        Text("Console needs ArtNet settings as \(settingsManager.returnZeroOrOne(self.settingsManager.zeroArt)) based")
                    }
                }
                Section(header: Text("About").padding(.top)){
                    NavigationLink(destination: Text("About")) {
                        Text("About the App")
                    }
                    NavigationLink(destination: Text("Tipping")) {
                        VStack(alignment: .leading) {
                            Text("Enjoying the app?")
                            Text("Tap here to add to the tip jar")
                                .font(.subheadline)
                        }
                    }
                }
                Section(header: Text("Support").padding(.top)){
                    Text("🐛 Bugs (🔗 to GitHub)").onTapGesture {
                        if let url = URL(string: "https://www.hackingwithswift.com") {
                            UIApplication.shared.open(url)
                        }
                    }
                    Text("⚒️ Requests (🔗 to GitHub)")
                    Text("✉️ Contact (🔗 to Email)")
                }
            }.navigationBarTitle("Settings & Info")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
