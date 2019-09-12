//
//  PrimUniView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct UniverseView: View {
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

struct UniverseView_Previews: PreviewProvider {
    static var previews: some View {
        UniverseView(uni: 8)
    }
}
