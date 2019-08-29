//
//  CalculateView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct CalculateView: View {
    var sub = 0
    var uni = 9
    var art = 8
    
    var body: some View {
        VStack {
            HStack {
                PrimUniView(uni: uni)
                Spacer()
                SubView(sub: sub)
                ArtUniView(uni: art)
            }
        }.padding()
    }
}

struct CalculateView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateView(sub: 0, uni: 10, art: 9)
    }
}
