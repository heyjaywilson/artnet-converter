//
//  CalculationManager.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import CoreData
import Combine

class CalculationManager: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    let managedContext: NSManagedObjectContext
    
    public var prim_uni: Int = 1 {
        willSet {
            self.objectWillChange.send()
        }
    }
    public var subnet: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
    public var art_uni: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    init(mc: NSManagedObjectContext){
        managedContext = mc
    }
    
    func addNumberToPrimUni(_ num: Int){
        let originalStr = "\(prim_uni)"
        let newStr = originalStr + "\(num)"
        
        prim_uni = Int(newStr)!
        if prim_uni > 255 {
            prim_uni = 256
        }
        
        calcArtUni()
    }
    
    func deleteNumberFromPrimUni(){
        if prim_uni <= 10 {
            prim_uni = 0
        } else {
            var originalStr = "\(prim_uni)"
            originalStr.removeLast()
            
            prim_uni = Int(originalStr)!
        }
        
        calcArtUni()
    }
    
    func calcSubnet() -> Int{
        print(prim_uni)
        if prim_uni == 0 {
            subnet = 0
            return 0
        }
        
        let  sub = prim_uni / 16
        
        subnet = sub
        print("SUB: \(sub)")
        return sub
    }
    
    func calcArtUni() {
        let uni = prim_uni - (self.calcSubnet() * 16)
        print(uni)
        art_uni = uni
    }
}
