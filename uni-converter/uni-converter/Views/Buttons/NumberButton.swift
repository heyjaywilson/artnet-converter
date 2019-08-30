//
//  NumberButton.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct NumberButton: View {
    @EnvironmentObject var calcManager: CalculationManager
    
    var num: Int
    let frameSize: CGFloat = 50.0
    
    var body: some View {
        Button(action: {
            self.calcManager.addNumberToPrimUni(self.num)
        }){
            Text("\(self.num)")
                .font(.title)
                .fontWeight(.bold)
            
        }
        .frame(width: frameSize, height: frameSize)
        .padding(.all, 15.0)
    }
}

struct NumberButton_Previews: PreviewProvider {
    static var previews: some View {
        NumberButton(num: 0)
    }
}
