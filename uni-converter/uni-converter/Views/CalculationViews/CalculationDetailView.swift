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
            }){
                Text("Add Note")
                
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
