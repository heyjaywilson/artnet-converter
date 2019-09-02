//
//  SettingsManager.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/2/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import Combine

class SettingsManager: ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    var listenToDevice: Bool = false {
        willSet {
            self.objectWillChange.send()
            self.defaults.set(newValue, forKey: "listenToDevice")
        }
    }
    var colorScheme: Bool = false {
           willSet {
               self.objectWillChange.send()
               self.defaults.set(newValue, forKey: "colorScheme")
           }
       }
    var zeroArt: Bool = true {
           willSet {
               self.objectWillChange.send()
               self.defaults.set(newValue, forKey: "zeroArt")
           }
       }
    var zeroUni: Bool = true {
           willSet {
               self.objectWillChange.send()
               self.defaults.set(newValue, forKey: "zeroUni")
           }
       }
    
    let defaults: UserDefaults
    
    init() {
        defaults = UserDefaults.standard
        if defaults.object(forKey: "listenToDevice") == nil {
          defaults.set(true, forKey: "listenToDevice")
        }
        if defaults.object(forKey: "colorScheme") == nil {
          defaults.set(false, forKey: "colorScheme")
        }
        if defaults.object(forKey: "zeroArt") == nil {
          defaults.set(true, forKey: "zeroArt")
        }
        if defaults.object(forKey: "zeroUni") == nil {
          defaults.set(true, forKey: "zeroUni")
        }
        
        
        listenToDevice = (defaults.value(forKey: "listenToDevice") != nil)
        colorScheme = (defaults.value(forKey: "colorScheme") != nil)
        zeroArt = (defaults.value(forKey: "zeroArt") != nil)
        zeroUni = (defaults.value(forKey: "zeroUni") != nil)
    }
}
