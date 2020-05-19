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
    let set: SettingsManager
    let objectWillChange = ObservableObjectPublisher()
    let managedContext: NSManagedObjectContext
    var mostRecentCalc: CalcEntity
    
    public var outputPrimaryUniverse: Int = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
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
    
    init(mc: NSManagedObjectContext, settings: SettingsManager){
        managedContext = mc
        mostRecentCalc = CalcEntity(context: managedContext)
        self.set = SettingsManager()
    }
    
    func setNum(primUni: Int){
        prim_uni = primUni
        outputPrimaryUniverse = prim_uni
    }
    func setNum(art: Int){
        art_uni = art
        subnet = art
    }
    
    func addNumberToPrimUni(_ num: Int){
        let isPrimaryUniverseZero: Bool = set.returnDefaults("zeroUni")
        let isArtNetZero: Bool = set.returnDefaults("zeroArt")
        let originalStr = "\(prim_uni)"
        let newStr = originalStr + "\(num)"
        
        prim_uni = Int(newStr)!
        if isPrimaryUniverseZero == false {
            if prim_uni > 256 {
                prim_uni = 256
                outputPrimaryUniverse = 256
            }
        } else {
            if prim_uni > 255 {
                prim_uni = 255
                outputPrimaryUniverse = 255
            }
        }
        outputPrimaryUniverse = prim_uni
        calcAll(isPrimaryUniverseOne: isPrimaryUniverseZero, isArtNetOne: isArtNetZero)
    }
    
    func deleteNumberFromPrimUni(_ num: Int){
        let isPrimaryUniverseOne: Bool = set.returnDefaults("zeroUni")
        let isArtNetOne: Bool = set.returnDefaults("zeroArt")
        
        print(prim_uni)
        if isPrimaryUniverseOne == true {
            if prim_uni < 20 && prim_uni > 1 {
                prim_uni = 1
                outputPrimaryUniverse = 1
                calcAll(isPrimaryUniverseOne: isPrimaryUniverseOne, isArtNetOne: isArtNetOne)
            } else if prim_uni == 1 {
                prim_uni = 0
                outputPrimaryUniverse = 1
            } else {
                var originalStr = "\(prim_uni)"
                originalStr.removeLast()
                prim_uni = Int(originalStr) ?? 1
                outputPrimaryUniverse = prim_uni
                calcAll(isPrimaryUniverseOne: isPrimaryUniverseOne, isArtNetOne: isArtNetOne)
            }
        } else {
            if prim_uni < 10 {
                prim_uni = 0
                outputPrimaryUniverse = prim_uni
                calcAll(isPrimaryUniverseOne: isPrimaryUniverseOne, isArtNetOne: isArtNetOne)
            } else {
                var originalStr = "\(prim_uni)"
                originalStr.removeLast()
                
                prim_uni = Int(originalStr)!
                outputPrimaryUniverse = prim_uni
                calcAll(isPrimaryUniverseOne: isPrimaryUniverseOne, isArtNetOne: isArtNetOne)
            }
        }
        
        print(prim_uni)
    }
    
    func setPimUni(to num: Int){
        let isPrimaryUniverseOne: Bool = set.returnDefaults("zeroUni")
        let isArtNetOne: Bool = set.returnDefaults("zeroArt")
        prim_uni = num
        outputPrimaryUniverse = prim_uni
        calcAll(isPrimaryUniverseOne: isPrimaryUniverseOne, isArtNetOne: isArtNetOne)
    }
    
    func calcSub(add: Int){
        subnet = (prim_uni/16) + add
    }
    
    func calcArtUni(add: Int){
        art_uni = (prim_uni % 16) + add
    }
    
    func calculateArtnet(add: Int){
        subnet = prim_uni / 16 + add
        art_uni = prim_uni % 16 + add
    }
    
    func calcAll(isPrimaryUniverseOne: Bool, isArtNetOne: Bool){
        
        if isPrimaryUniverseOne == true {
            // ArtNet 0 based
            if isArtNetOne == false {
                if prim_uni % 16 == 0 {
                    calcSub(add: -1)
                    calcArtUni(add: 15)
                } else {
                    calcSub(add: 0)
                    calcArtUni(add: -1)
                }
            }
            // ArtNet 1 based
            else {
                if prim_uni % 16 == 0 {
                    calcSub(add: 0)
                    calcArtUni(add: 16)
                } else {
                    calcSub(add: 1)
                    calcArtUni(add: 0)
                }
            }
        } else {
            if isArtNetOne == true {
                calculateArtnet(add: 1)
            } else {
                calculateArtnet(add: 0)
            }
        }
    }
    
    func saveCalculation() {
        let universe: Bool = set.returnDefaults("zeroUni")
        let art: Bool = set.returnDefaults("zeroArt")
        
        let newCalc = CalcEntity(context: managedContext)
        newCalc.artuni = Int64(art_uni)
        newCalc.subnet = Int64(subnet)
        newCalc.priuni = Int64(prim_uni)
        newCalc.id = UUID()
        newCalc.date = Date()
        newCalc.isZeroUni = universe
        newCalc.isZeroArt = art
        
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
    
    func deleteCalc(_ calcEnt: CalcEntity) {
        self.managedContext.delete(calcEnt)
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
                if calc.id != nil{
                    self.calcs.append(calc)
                }
            }
        }
    }
    
}
