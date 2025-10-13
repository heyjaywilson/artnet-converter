//
//  SFSymbol.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/6/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import Foundation
import SwiftUI

enum SFSymbol: String, CaseIterable {
    case lightbulbMinFill = "lightbulb.min.fill"
    case questionMarkCircle = "questionmark.circle"
    case arrowClockwiseCircle = "arrow.clockwise.circle"
    case link
    case clockArrowTrianglehead2CounterClockwiseRotate90 = "clock.arrow.trianglehead.2.counterclockwise.rotate.90"
}

#Preview {
    List {
        ForEach(
            SFSymbol.allCases.sorted(by: { $0.rawValue < $1.rawValue}),
            id: \.rawValue
        ) { symbol in
            HStack {
                Image(systemName: symbol.rawValue)
                Text(symbol.rawValue)
            }
        }
    }
}
