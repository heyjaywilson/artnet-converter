//
//  SubView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct SubView: View {
  @EnvironmentObject var settingsManager: SettingsManager
  var sub: Int
  var body: some View {
    VStack {
      Text("subnet")
        .font(.subheadline)
      Text(determineOut())
        .font(.title)
    }
  }
  
  func determineOut() -> String {
    var output = ""
    if settingsManager.showHex {
      output = showHex()
    } else {
      output = "\(sub)"
    }
    return output
  }
  
  func showHex() -> String{
    let hexValue = String(format:"%0X", sub)
    return hexValue
  }
}

struct SubView_Previews: PreviewProvider {
  static var previews: some View {
    SubView(sub: 0)
  }
}
