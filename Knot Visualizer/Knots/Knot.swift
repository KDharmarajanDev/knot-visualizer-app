//
//  Knot
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/27/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

class Knot {
    
    var knotStates : Array<KnotState> = []
    var currIndex : Int
    
    init(_ knotStates : Array<KnotState>) {
        currIndex = 0
        self.knotStates = knotStates
    }
}
