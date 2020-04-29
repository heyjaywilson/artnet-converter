//
//  UserSettings.swift
//  uni-converter
//
//  Created by Maegan Wilson on 4/29/20.
//  Copyright © 2020 MW. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefault<T> {
  let key: String
  let defaultValue: T
  
  init(_ key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: T {
    get {
      return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
    set {
      UserDefaults.standard.set(newValue, forKey: key)
    }
  }
}

final class UserSettings: ObservableObject {
  
  let objectWillChange = PassthroughSubject<Void, Never>()
  
  @UserDefault("zeroArt", defaultValue: false)
  var zeroArt: Bool {
    willSet {
      objectWillChange.send()
    }
  }
  @UserDefault("zeroUni", defaultValue: false)
  var zeroUni: Bool {
    willSet {
      objectWillChange.send()
    }
  }
  @UserDefault("showHex", defaultValue: false)
  var showHex: Bool {
    willSet {
      objectWillChange.send()
    }
  }
  
  @UserDefault("isiPad", defaultValue: true)
  var isiPad: Bool {
    willSet {
      objectWillChange.send()
    }
  }
}
