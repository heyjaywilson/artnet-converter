//
//  PrimUniView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct PrimUniView: View {
    var uni: Int
    var body: some View {
        VStack {
            Text("universe")
                .font(.subheadline)
            Text("\(uni)")
                .font(.title)
        }
    }
}

struct PrimUniView_Previews: PreviewProvider {
    static var previews: some View {
        PrimUniView(uni: 8)
    }
}
