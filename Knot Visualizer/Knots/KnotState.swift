//
//  KnotState.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/27/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//
class KnotState : Equatable {
    
    var nameOfModel : String
    
    init(_ nameOfModel : String) {
        self.nameOfModel = nameOfModel
    }
    
    static func == (lhs: KnotState, rhs: KnotState) -> Bool {
        return lhs.nameOfModel == rhs.nameOfModel
    }
}
