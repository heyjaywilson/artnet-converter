//
//  URL.swift
//  uni-converter
//
//  Created by Jay Wilson on 10/13/25.
//  Copyright © 2025 CCT Plus LLC. All rights reserved.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: String { self.absoluteString }
}
