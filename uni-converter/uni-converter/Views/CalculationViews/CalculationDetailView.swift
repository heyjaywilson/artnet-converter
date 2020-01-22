//
//  CalculationDetailView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/30/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct CalculationDetailView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @EnvironmentObject var calcManager: CalculationManager
  @EnvironmentObject var settingsManager: SettingsManager
  
  @State private var showNewNote: Bool = false
  @State private var noteText: String = ""
  @State private var notes: [String] = []
  
  @State private var sub: String = ""
  @State private var uni: String = ""
  
  @State var calc: CalcEntity
  
  var body: some View {
    List{
      Section(header: Text("ArtNet")) {
        Text("Subnet: \(sub)")
        Text("Universe: \(uni)")
      }.onAppear{
        self.getNotes()
      }
      Section(header: Text("Notes")){
        ForEach(notes, id: \.self){ note in
          Text("\(note)")
        }
      }
    }.onAppear{
      self.getAnswers()
    }
    .padding(.top)
    .listStyle(GroupedListStyle())
    .navigationBarTitle("Primary Universe: \(calc.priuni)")
    .navigationBarItems(trailing:
      Button(action: {
        print("add note")
        self.showNewNote = true
      }){
        Text("Add Note")
      }.sheet(isPresented: $showNewNote){
        NewNoteForm(calc: self.$calc, notes: self.$notes)
          .environment(\.managedObjectContext, self.managedObjectContext)
          .environmentObject(self.calcManager)
      }
    )
  }
  func getAnswers(){
    if settingsManager.showHex {
      sub = getHex(num: Int(calc.subnet))
      uni = getHex(num: Int(calc.artuni))
    } else {
      sub = "\(calc.subnet)"
      uni = "\(calc.artuni)"
    }
  }
  
  func getHex(num: Int) -> String {
    let hexValue = String(format:"%0X", num)
    return hexValue
  }
  
  func getNotes() {
    let allNotes = Array<Any>(calc.notes ?? [])
    notes = []
    for note in allNotes as! [NoteEntity]{
      if !note.note!.isEmpty {
        notes.append(note.note!)
      }
    }
  }
}
