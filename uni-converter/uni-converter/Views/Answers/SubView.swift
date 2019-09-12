//
//  SubView.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import SwiftUI

struct SubView: View {
    var sub: Int
    var body: some View {
        VStack {
            Text("subnet")
                .font(.subheadline)
            Text("\(sub)")
                .font(.title)
        }
    }
}

struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        SubView(sub: 0)
    }
}
