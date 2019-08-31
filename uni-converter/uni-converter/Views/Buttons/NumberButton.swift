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
    
    @Binding var toggle: Bool
    var num: Int
    let frameSize: CGFloat = 80.0
    
    var body: some View {
        Button(action: {
            if self.toggle == true {
                self.toggle = false
                self.calcManager.setPimUni(to: 0)
            }
            self.calcManager.addNumberToPrimUni(self.num)
        }){
            Text("\(self.num)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: frameSize, height: frameSize)
                .background(Color.gray)
                .cornerRadius(2.0)
                .padding(.all, 10.0)
        }
    }
}

//struct NumberButton_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberButton(num: 0)
//    }
//}
