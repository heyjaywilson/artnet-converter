//
//  Settings.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State private var listenToDevice: Bool = false
    @State private var colorScheme: Bool = false
    @State private var zeroArt: Bool = true
    @State private var zeroUni: Bool = true
    
    var body: some View {
        Form {
            Section(header: Text("Color Scheme")){
                Toggle(isOn: $listenToDevice) {
                    Text("Listen to device for color scheme")
                }
                Toggle(isOn: $colorScheme){
                    Text(self.colorScheme ? "Dark mode on" : "Dark mode off")
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
