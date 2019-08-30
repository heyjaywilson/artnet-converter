//
//  AllButtons.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct AllButtons: View {
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    print("Back")
                }){
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                }
                .frame(width: 50.0, height: 50.0)
                .padding(.all, 15.0)
                Spacer()
                Button(action: {
                    print("P -> A")
                }){
                    Text("Uni -> ArtNet")
                }
            }
            HStack{
                NumberButton(num: 7)
                NumberButton(num: 8)
                NumberButton(num: 9)
            }
            HStack{
                NumberButton(num: 4)
                NumberButton(num: 5)
                NumberButton(num: 6)
            }
            HStack{
                NumberButton(num: 1)
                NumberButton(num: 2)
                NumberButton(num: 3)
            }
            HStack{
                NumberButton(num: 0)
            }
        }
    }
}

struct AllButtons_Previews: PreviewProvider {
    static var previews: some View {
        AllButtons()
    }
}
