//
//  PersistenceController.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/4/25.
//  Copyright © 2025 MW. All rights reserved.
//

import Foundation
import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  static var preview: PersistenceController = {
    let controller = PersistenceController(inMemory: true)
    return controller
  }()
  
  let container: NSPersistentContainer
  
  var viewContext: NSManagedObjectContext {
    return container.viewContext
  }
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "uni_converter")
    
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Error: \(error.localizedDescription)")
      }
    }
  }
  
  func save() {
    let context = container.viewContext
    
    do {
      try context.save()
    } catch {
      print(error)
    }
  }
}
