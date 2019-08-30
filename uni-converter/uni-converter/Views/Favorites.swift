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
        List(calcManager.calcs, id: \.id!) { calc in
            CalculationRowView(calc: calc)
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
