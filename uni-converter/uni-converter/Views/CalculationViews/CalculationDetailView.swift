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
    
    @State private var showNewNote: Bool = false
    @State private var noteText: String = ""
    
    var calc: CalcEntity
    
    var body: some View {
        List{
            Section(header: Text("ArtNet")) {
                Text("Subnet: \(calc.subnet)")
                Text("Universe: \(calc.artuni)")
            }
            Section(header: Text("Notes")){
                Text("HI")
            }
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
                NewNoteForm(id: self.calc.id, calc: self.calc).environment(\.managedObjectContext, self.managedObjectContext)
            }
        )
    }
}

//struct CalculationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculationDetailView()
//    }
//}
