//
//  SettingsManager.swift
//  uni-converter
//
//  Created by Maegan Wilson on 9/2/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SettingsManager: ObservableObject {
  @Environment(\.colorScheme) var colorScheme
  
  let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
  
  let defaults: UserDefaults = UserDefaults.standard
  var zeroArt: Bool {
    willSet {
      self.objectWillChange.send()
      self.defaults.set(newValue, forKey: "zeroArt")
    }
  }
  var zeroUni: Bool {
    willSet {
      self.objectWillChange.send()
      self.defaults.set(newValue, forKey: "zeroUni")
    }
  }
  var showHex: Bool {
    willSet {
      self.objectWillChange.send()
      self.defaults.set(newValue, forKey: "showHex")
    }
  }
  
  init() {
    if defaults.object(forKey: "zeroArt") == nil {
      defaults.set(true, forKey: "zeroArt")
    }
    if defaults.object(forKey: "zeroUni") == nil {
      defaults.set(true, forKey: "zeroUni")
    }
    if defaults.object(forKey: "showHex") == nil {
      defaults.set(false, forKey: "showHex")
    }
    
    zeroArt = defaults.bool(forKey: "zeroArt")
    zeroUni = defaults.bool(forKey: "zeroUni")
    showHex = defaults.bool(forKey: "showHex")
  }
  
  func printDefaults(){
    print("\(defaults.bool(forKey: "zeroArt") ) || \(zeroArt)")
    print("\(defaults.bool(forKey: "zeroUni") ) || \(zeroUni)")
  }
  
  func returnZeroOrOne(_ prop: Bool) -> Int{
    if prop {
      return 1
    }
    return 0
  }
  
  func returnDefaults(_ type: String) -> Bool{
    switch type {
      case "zeroArt":
        return defaults.bool(forKey: "zeroArt")
      default:
        return defaults.bool(forKey: "zeroUni")
    }
  }
}
