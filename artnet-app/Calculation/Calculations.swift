//
//  ModelController.swift
//  artnet-app
//
//  Created by Maegan Wilson on 7/5/18.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Calculations {
    var calcs: [NSManagedObject] = []
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Calc")
        
        do {
            calcs = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func count() -> Int {
        return calcs.count
    }
    
    func calcSubUni(fixtureUniverse: Int) -> [Int] {
        var subnet = fixtureUniverse/16
        if (fixtureUniverse % 16 == 0) {
            subnet = subnet - 1
        }
        let universe = fixtureUniverse - (subnet * 16) - 1
        
        return [subnet, universe]
    }
    
    func calcFixtureUniverse(subnet: Int, universe: Int) -> Int {
        let fixtureUniverse = universe + (subnet * 16) + 1
        return fixtureUniverse
    }
    
    func addCalculation(fixtureUniverse: Int, subnet: Int, universe: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Calc", in: managedContext)!
        
        let calc = NSManagedObject(entity: entity, insertInto: managedContext)
        
        calc.setValue(subnet, forKeyPath: "subnet")
        calc.setValue(universe, forKeyPath: "universe")
        calc.setValue(fixtureUniverse, forKeyPath: "fixtureUniverse")
        
        do {
            try managedContext.save()
            calcs.append(calc)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getCalc(index: Int) -> NSManagedObject {
        return calcs[index]
    }
    
//    func addNote(index: Int, note: String) {
//        calcs[index].note.append(note)
//    }
//
//    func editNote(calcLoc: Int, noteLoc: Int, note: String){
//        calcs[calcLoc].note[noteLoc] = note
//    }
//
//    func replaceCalc(calcLoc: Int, calc: Calc){
//        calcs[calcLoc] = calc
//    }
}
