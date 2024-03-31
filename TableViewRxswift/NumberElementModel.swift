//
//  Model.swift
//  TableViewRxswift
//
//  Created by 최준영 on 4/1/24.
//

import Foundation

class NumberElementModel {
    
    let id: Int
    let number: Int
    var isInside: Bool
    
    init(id: Int, number: Int, isInside: Bool) {
        self.id = id
        self.number = number
        self.isInside = isInside
    }
}
