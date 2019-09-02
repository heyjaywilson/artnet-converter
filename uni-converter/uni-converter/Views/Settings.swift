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
            Section(header: Text("Color Scheme")){
                Toggle(isOn: $settingsManager.listenToDevice) {
                    Text("Listen to device for color scheme")
                }
//                Toggle(isOn: $settingsManager.colorScheme){
//                    Text(self.colorScheme ? "Dark mode on" : "Dark mode off")
//                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
