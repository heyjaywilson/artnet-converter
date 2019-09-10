//
//  Favorites.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct Favorites: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var calcManager: CalculationManager
    
    var body: some View {
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
                        CalculationRowView(calc: calc)
                    }
                }.onDelete(perform: delete)
            }
        .navigationBarTitle("Saved Calculations")
        }.onAppear{
            self.calcManager.getCalcs()
        }
    }
    
    func delete(at offsets: IndexSet){
        let temp = calcManager.calcs[offsets]
        calcManager.deleteCalc(temp[0])
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
