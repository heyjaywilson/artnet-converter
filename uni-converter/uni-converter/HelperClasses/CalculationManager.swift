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
    var mostRecentCalc: CalcEntity
    
    public var prim_uni: Int = 0 {
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
    public var calcs: [CalcEntity] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    init(mc: NSManagedObjectContext){
        managedContext = mc
        mostRecentCalc = CalcEntity(context: managedContext)
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
    
    func setPimUni(to num: Int){
        prim_uni = num
        calcArtUni()
    }
    
    func calcSubnet() -> Int{
        if prim_uni == 0 {
            subnet = 0
            return 0
        }
        
        let  sub = prim_uni / 16
        
        subnet = sub
        return sub
    }
    
    func calcArtUni() {
        let uni = prim_uni - (self.calcSubnet() * 16)
        art_uni = uni
        getCalcs()
    }
    
    func saveCalculation() {
        let newCalc = CalcEntity(context: managedContext)
        newCalc.artuni = Int64(art_uni)
        newCalc.subnet = Int64(subnet)
        newCalc.priuni = Int64(prim_uni)
        newCalc.id = Int64(self.calcs.count)
        newCalc.date = Date()
        
        do {
            try self.managedContext.save()
            self.mostRecentCalc = newCalc
            self.getCalcs()
        } catch {
            print(error)
        }
    }
    
    func deleteCalc() {
        self.managedContext.delete(mostRecentCalc)
        do {
            try self.managedContext.save()
            self.getCalcs()
        } catch {
            print(error)
        }
    }
    
    func getCalcs() {
        if let fetched = try? managedContext.fetch(CalcEntity.allCalcs()){
            self.calcs = []
            for calc in fetched {
                self.calcs.append(calc)
            }
        }
    }
    
    func deleteCalc(_ calcEnt: CalcEntity) {
        self.managedContext.delete(calcEnt)
        do {
            try self.managedContext.save()
            self.getCalcs()
        } catch {
            print(error)
        }
    }
}
