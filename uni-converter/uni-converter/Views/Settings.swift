//
//  Settings.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI
import RevenueCatUI

struct Settings: View {
  @EnvironmentObject var settingsManager: SettingsManager
  
  let website_URL: URL = URL(string: "https://heyjaywilson.github.io/artnet-converter/")!
  let bug_URL = URL(string: "https://github.com/heyjaywilson/artnet-converter/issues/new?assignees=&labels=&template=bug_report.md&title=BUG")!
  
  let request_URL: URL = URL(string: "https://github.com/heyjaywilson/artnet-converter/issues/new?assignees=&labels=&template=feature_request.md&title=FEATURE")!
  
  let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
  
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
          Toggle(isOn: $settingsManager.showHex) {
            Text("Console needs Hex values")
          }
        }
        Section(header: Text("About").padding(.top)){
          NavigationLink(destination: AboutView()) {
            VStack(alignment: .leading) {
              Text("About the App")
              Text("Version: \(appVersion ?? "VERSION INFO ERROR") (\(appBuild ?? "BUILD"))")
                .font(.subheadline)
                .foregroundColor(.green)
            }
          }
    
          NavigationLink(destination: PaywallView()) {
            VStack(alignment: .leading) {
              Text("👍 Enjoying the app?")
              Text("Support it with a cup of coffee!  ")
                .font(.subheadline)
                .foregroundColor(.gray)
            }
          }
          NavigationLink(destination: WebView(url: website_URL)){
            VStack(alignment: .leading){
              Text("🖥️ App Website (🔗 to website)")
            }
          }
        }
        Section(header: Text("Support").padding(.top)){
          NavigationLink(destination: WebView(url: bug_URL)){
            VStack(alignment: .leading){
              Text("🐛 Bugs (🔗 to GitHub)")
              Text("Will need GitHub account to report issue")
                .font(.subheadline)
                .foregroundColor(.gray)
            }
          }
          NavigationLink(destination: WebView(url: request_URL)){
            VStack(alignment: .leading){
              Text("⚒️ Requests (🔗 to GitHub)")
              Text("Will need GitHub account to report issue")
                .font(.subheadline)
                .foregroundColor(.gray)
            }
          }
        }
      }
      .navigationBarTitle("Settings & Info")
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}

struct Settings_Previews: PreviewProvider {
  static var previews: some View {
    Settings()
  }
}
