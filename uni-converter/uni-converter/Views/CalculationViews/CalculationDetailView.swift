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
            }.alert(isPresented: self.$showNewNote){
                Alert(title: Text("New Note"), message: Text("This will have a new note"), primaryButton: .default(Text("Add note")), secondaryButton: .cancel())
            }
        )
    }
    
    func addNote(){
        print("add note")
        print("add note to this calc")
    }
}

//struct CalculationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculationDetailView()
//    }
//}
