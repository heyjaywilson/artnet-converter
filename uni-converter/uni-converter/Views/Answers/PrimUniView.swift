//
//  PrimUniView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct UniverseView: View {
  var isPrimeUni = false
  var uni: Int
  var body: some View {
    VStack {
      Text("universe")
        .font(.subheadline)
      Text(determineOutput())
        .font(.title)
    }
  }
  
  func determineOutput() -> String{
    var output = ""
    if isPrimeUni {
      output = "\(uni)"
    } else {
      // check userdefault for hex
      // if true output = showHex()
    }
    return output
  }
  
  func showHex() -> String{
    let hexValue = String(format:"%02X", uni)
    return hexValue
  }
}

struct UniverseView_Previews: PreviewProvider {
  static var previews: some View {
    UniverseView(uni: 8)
  }
}
