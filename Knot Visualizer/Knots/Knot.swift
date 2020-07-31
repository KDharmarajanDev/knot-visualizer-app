//
//  Knot
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/27/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//
import UIKit

class Knot : Equatable {
    
    var knotStates : Array<KnotState> = []
    var currIndex : Int
    var thumbnail : UIImage
    var name : String
    
    init(_ knotStates : Array<KnotState>, _ thumbnail : UIImage, _ name : String) {
        currIndex = 0
        self.knotStates = knotStates
        self.thumbnail = thumbnail
        self.name = name
    }
    
    static func == (lhs : Knot, rhs : Knot) -> Bool {
        if lhs.knotStates.count == rhs.knotStates.count {
            for (i, knotState) in lhs.knotStates.enumerated() {
                if knotState != rhs.knotStates[i] {
                    return false
                }
            }
        } else {
            return false
        }
        return lhs.thumbnail == rhs.thumbnail && lhs.name == rhs.name
    }
}
