//
//  NewNoteForm.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/30/19.
//  Copyright © 2019 MW. All rights reserved.
//

import CoreData
import SwiftUI

struct NewNoteForm: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var enteredText: String = ""
    let id: Int64
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Note text", text: $enteredText)
            }
            .navigationBarTitle("New Note")
            .navigationBarItems(trailing:
                Button(action: {
                    self.saveNote()
                }) {
                    Text("Save")
            })
        }
    }
    
    func saveNote() {
        print("Save")
        var calc: CalcEntity
        let request: NSFetchRequest<CalcEntity> = CalcEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id MATCHES[c] '\(id)'")
        if let calcs = try? managedObjectContext.fetch(request) {
            if calcs.count > 0 {
                calc = calcs[0]
            }
        }
        
        let note = NoteEntity(context: managedObjectContext)
        self.presentationMode.wrappedValue.dismiss()
    }
}

//struct NewNoteForm_Previews: PreviewProvider {
//    static var previews: some View {
//        NewNoteForm()
//    }
//}
