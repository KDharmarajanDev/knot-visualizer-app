//
//  Knot
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/27/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//
import UIKit

class Knot {
    
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
}
