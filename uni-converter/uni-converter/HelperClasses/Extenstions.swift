//
//  Extenstions.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/30/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import UIKit

extension Collection {
  subscript<T: Sequence>(idx: T) -> [Element]
    where T.Element == Index {
    get { return idx.map{ self[$0] } }
  }
}

public extension UIDevice {
  
  static let modelName: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
      #if os(iOS)
      switch identifier {
        case "iPod5,1":                                 return "small iPod touch (5th gen)"
        case "iPod7,1":                                 return "small iPod touch (6th gen)"
        case "iPod9,1":                                 return "small iPod touch (7th gen)"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "small iPhone 4"
        case "iPhone4,1":                               return "small iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "small iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "small iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "small iPhone 5s"
        case "iPhone7,2":                               return "small iPhone 6"
        case "iPhone7,1":                               return "medium iPhone 6 Plus"
        case "iPhone8,1":                               return "small iPhone 6s"
        case "iPhone8,2":                               return "medium iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "small iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "medium iPhone 7 Plus"
        case "iPhone8,4":                               return "small iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "small iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "medium iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "medium iPhone X"
        case "iPhone11,2":                              return "medium iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "medium iPhone XS Max"
        case "iPhone11,8":                              return "medium iPhone XR"
        case "iPhone12,1":                              return "medium iPhone 11"
        case "iPhone12,3":                              return "medium iPhone 11 Pro "
        case "iPhone12,5":                              return "medium iPhone 11 Pro Max"
        // iPad 2s
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "medium iPad"
        // iPad 3rd gen
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "medium iPad"
        // iPad 4th gen
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "medium iPad"
        // iPad 5th gen
        case "iPad6,11", "iPad6,12":                    return "medium iPad"
        // iPad 7th gen
        case "iPad7,5", "iPad7,6":                      return "medium iPad"
        // iPad 8th gen
        case "iPad7,11", "iPad7,12":                    return "medium iPad"
        // iPad Air
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "medium iPad"
        // iPad Air 2
        case "iPad5,3", "iPad5,4":                      return "medium iPad"
        // iPad Air 3rd gen
        case "iPad11,4", "iPad11,5":                    return "medium iPad"
        // iPad mini
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "medium iPad"
        // iPad mini 2
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "medium iPad"
        // iPad mini 3
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "medium iPad"
        // iPad mini 4
        case "iPad5,1", "iPad5,2":                      return "medium iPad"
        // iPad mini 5th gen
        case "iPad11,1", "iPad11,2":                    return "medium iPad"
        // iPad Pro 9.7"
        case "iPad6,3", "iPad6,4":                      return "medium iPad Pro (9.7-inch)"
        // iPad Pro 12.9"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
        // iPad Pro 12.9" 2nd gen
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        // iPad Pro 10.5"
        case "iPad7,3", "iPad7,4":                      return "medium iPad Pro (10.5-inch)"
        // iPad Pro 11" 3rd gen
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "medium iPad Pro (11-inch)"
        // iPad Pro 12.9" 3rd gen
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
        default:                                        return identifier
      }
      #elseif os(tvOS)
      switch identifier {
        case "AppleTV5,3": return "Apple TV 4"
        case "AppleTV6,2": return "Apple TV 4K"
        case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
        default: return identifier
      }
      #endif
    }
    
    return mapToDevice(identifier: identifier)
  }()
  
}
