//
//  ArtUniView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct ArtUniView: View {
   var uni: Int
    var body: some View {
        VStack {
            Text("art-net universe")
                .font(.subheadline)
            Text("\(uni)")
                .font(.title)
        }
    }
}

struct ArtUniView_Previews: PreviewProvider {
    static var previews: some View {
        ArtUniView(uni: 7)
    }
}
