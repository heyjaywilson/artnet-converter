//
//  ModelController.swift
//  artnet-app
//
//  Created by Maegan Wilson on 7/5/18.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class Calculations {
    var calcs: Array<Calc>
    
    init() {
        calcs = [Calc]()
    }
    
    func addCalc(calculation: Calc){
        calcs.append(calculation)
    }
    
    func addNote(index: Int, note: String) {
        calcs[index].note.append(note)
    }
    
    func editNote(calcLoc: Int, noteLoc: Int, note: String){
        calcs[calcLoc].note[noteLoc] = note
    }
    
    func replaceCalc(calcLoc: Int, calc: Calc){
        calcs[calcLoc] = calc
    }
}
