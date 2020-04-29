//
//  CalcSavedView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 4/29/20.
//  Copyright © 2020 MW. All rights reserved.
//

import SwiftUI

struct CalcSavedView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @EnvironmentObject var calcManager: CalculationManager
  @EnvironmentObject var settingsManager: SettingsManager
  
  @State private var display: Bool = false
  @State private var calcAddNote: CalcEntity = CalcEntity()
  @State private var notes: [String] = []
  
  var body: some View {
    HStack{
      VStack {
        HStack {
          UniverseView(isPrimeUni: true, uni: calcManager.prim_uni)
          Spacer()
          Group{
            SubView(sub: calcManager.subnet)
              .padding(.trailing)
            UniverseView(uni: calcManager.art_uni)
          }
        }
        .padding(.horizontal)
        .padding(.top, 50)
        Spacer()
        AllButtons()
          .padding(.bottom, 50)
      }
      NavigationView{
        List{
          VStack{
            Text("What do the colors mean?")
              .font(.body)
            HStack{
              Text("Red text is 1 based")
                .font(.headline)
                .foregroundColor(.red)
              Spacer()
              Text("Blue text is 0 based")
                .font(.headline)
                .foregroundColor(.blue)
            }.padding(.bottom, 5)
          }
          ForEach(calcManager.calcs, id: \.id){ calc in
            NavigationLink(destination: CalculationDetailView(calc: calc)) {
              CalculationRowView(calc: calc, display: self.$display, calcAddNote: self.$calcAddNote)
            }
          }
          .onDelete(perform: delete)
        }
        .navigationBarTitle("Saved Calculations")
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .sheet(isPresented: $display){
        NewNoteForm(calc: self.$calcAddNote, notes: self.$notes)
          .environment(\.managedObjectContext, self.managedObjectContext)
          .environmentObject(self.calcManager)
      }
    }.onAppear{
      self.calcManager.getCalcs()
      if self.calcManager.prim_uni <= 1 {
        self.calcManager.setNum(art: self.settingsManager.returnZeroOrOne(self.settingsManager.zeroArt))
        self.calcManager.setNum(primUni: self.settingsManager.returnZeroOrOne(self.settingsManager.zeroUni))
      }
    }
  }
  
  
  func delete(at offsets: IndexSet){
    let temp = calcManager.calcs[offsets]
    calcManager.deleteCalc(temp[0])
  }
}
