//
//  NoteEntity+properties.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/30/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import CoreData

extension NoteEntity {
    static func allNotes() -> NSFetchRequest<NoteEntity> {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
    
    static func notesForCalc(_ id: Int64) -> NSFetchRequest<NoteEntity> {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id MATCHES[c] '\(id)'")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
}
