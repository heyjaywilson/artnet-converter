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
                    NavigationLink(destination: WebView(url: "https://github.com/maeganjwilson/artnet-converter/issues/new?assignees=&labels=&template=bug_report.md&title=🐛")){
                        Text("🐛 Bugs (🔗 to GitHub)")
                    }
                    NavigationLink(destination: WebView(url: "https://github.com/maeganjwilson/artnet-converter/issues/new?assignees=&labels=&template=feature_request.md&title=⚒%EF%B8%8F")){
                        Text("⚒️ Requests (🔗 to GitHub)")
                    }
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
