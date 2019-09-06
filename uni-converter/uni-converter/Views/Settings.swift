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
        Form {
            Section(header: Text("Universe Settings")){
                Toggle(isOn: $settingsManager.zeroUni) {
                    Text("Primary Universes is \(settingsManager.returnZeroOrOne(self.settingsManager.zeroUni))")
                }
                Toggle(isOn: $settingsManager.zeroArt) {
                    Text("Console needs ArtNet settings as \(settingsManager.returnZeroOrOne(self.settingsManager.zeroArt)) based")
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
