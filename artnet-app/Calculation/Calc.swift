//
//  Calculation.swift
//  artnet-app
//
//  Created by Maegan Wilson on 7/5/18.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct Calc {
    let universe: String
    let artsub: String
    let artuni: String
    var note: [String]
    
    func returnNote(index: Int) -> String {
        return note[index]
    }
}
