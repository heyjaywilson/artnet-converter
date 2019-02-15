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
    
    /**
    It calculates and returns the ArtNet subnet and universe.
    
    - Parameter fixtureUniverse: The universe on the fixture or the primary universe on the node
    - Returns: An array containing two integers [Subnet, Universe]
    */
    func calcSubUni(fixtureUniverse: Int) -> [Int] {
        var subnet = fixtureUniverse/16
        if (fixtureUniverse % 16 == 0) {
            subnet = subnet - 1
        }
        let universe = fixtureUniverse - (subnet * 16) - 1
        
        return [subnet, universe]
    }
    
    /**
    It calculates and returns the Fixture Universe.
    
    - Parameter subnet: The ArtNet subnet
    - Parameter universe: The ArtNet universe
    - Returns: The Fixture Universe
    */
    func calcFixtureUniverse(subnet: Int, universe: Int) -> Int {
        let fixtureUniverse = universe + (subnet * 16) + 1
        return fixtureUniverse
    }
    
    /**
    Adds the numbers to Core Data.
     
     - Parameter subnet: The ArtNet subnet that is used to calculate the Fixture Universe or is calculated from the fixture universe
     - Parameter universe: The ArtNet universe that is used to calculate the Fixture Universe or is calculated from the fixture universe
     - Parameter fixtureUniverse: The Fixture Universe that could be calculated from subnet and universe or given and used to calculate the subnet/universe
    */
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
    
    /**
    Returns the calculation for a given index
    */
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
