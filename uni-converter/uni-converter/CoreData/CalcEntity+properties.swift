//
//  CalcEntity+properties.swift
//  uni-converter
//
//  Created by Maegan Wilson on 8/29/19.
//  Copyright © 2019 MW. All rights reserved.
//

import Foundation
import CoreData

extension CalcEntity {
    static func allCalcs() -> NSFetchRequest<CalcEntity> {
        let request: NSFetchRequest<CalcEntity> = CalcEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }
}
