//
//  ContentView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var calcManager: CalculationManager
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection){
            CalculateView().environmentObject(calcManager)
                .tabItem {
                    VStack {
                        Image(systemName: "square.grid.2x2")
                        Text("Calc")
                    }
            }
            .tag(0)
            
            Favorites().environment(\.managedObjectContext, managedObjectContext)
                .tabItem {
                    VStack {
                        Image(systemName: "heart.circle")
                        Text("Saved")
                    }
            }
            .tag(1)
            
            Settings()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .tag(2)
        }.onAppear{
            self.calcManager.getCalcs()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @EnvironmentObject var calcManager: CalculationManager
    static var previews: some View {
        ContentView()
    }
}
