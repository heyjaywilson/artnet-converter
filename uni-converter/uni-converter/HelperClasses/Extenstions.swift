//
//  Extenstions.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/30/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation

extension Collection {
    subscript<T: Sequence>(idx: T) -> [Element]
        where T.Element == Index {
        get { return idx.map{ self[$0] } }
    }
}
