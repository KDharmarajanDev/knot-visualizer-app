//
//  KnotParserTest.swift
//  Knot VisualizerTests
//
//  Created by Karthik Dharmarajan on 7/30/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import XCTest
import UIKit
@testable import Knot_Visualizer

class KnotParserTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSquareKnot() {
        let desiredKnot = Knot([KnotState("State1.jpg"), KnotState("State2.jpg"), KnotState("State3.jpg")
        ], UIImage(named: "SquareKnot.jpg")!, "Square Knot")
        let knotParser = KnotParser("SquareKnotTest")
        knotParser.parse()
        let testKnot = knotParser.knots[0]
        XCTAssertEqual(desiredKnot,
                       testKnot)
    }
    
    func testBowlineKnot() {
        let desiredKnot = Knot([KnotState("State1.jpg"), KnotState("State2.jpg"), KnotState("State3.jpg"), KnotState("State4.jpg")
        ], UIImage(named: "Bowline.jpeg")!, "Bowline Knot")
        let knotParser = KnotParser("BowlineKnotTest")
        knotParser.parse()
        let testKnot = knotParser.knots[0]
        XCTAssertEqual(desiredKnot,
                       testKnot)
    }
    
    func testSheepShankKnot() {
        let desiredKnot = Knot([KnotState("State1.jpg"), KnotState("State2.jpg"), KnotState("State3.jpg"), KnotState("State4.jpg"), KnotState("State5.jpg")
        ], UIImage(named: "Sheepshank.jpg")!, "Sheepshank Knot")
        let knotParser = KnotParser("SheepshankKnotTest")
        knotParser.parse()
        let testKnot = knotParser.knots[0]
        XCTAssertEqual(desiredKnot,
                       testKnot)
    }
    
    func testCombinedKnots() {
        let squareKnot = Knot([KnotState("State1.jpg"), KnotState("State2.jpg"), KnotState("State3.jpg")
        ], UIImage(named: "SquareKnot.jpg")!, "Square Knot")
        let bowlineKnot = Knot([KnotState("State1.jpg"), KnotState("State2.jpg"), KnotState("State3.jpg"), KnotState("State4.jpg")
        ], UIImage(named: "Bowline.jpeg")!, "Bowline Knot")
        let sheepShankKnot = Knot([KnotState("State1.jpg"), KnotState("State2.jpg"), KnotState("State3.jpg"), KnotState("State4.jpg"), KnotState("State5.jpg")
        ], UIImage(named: "Sheepshank.jpg")!, "Sheepshank Knot")
        let knots : Array<Knot> = [squareKnot, bowlineKnot, sheepShankKnot]
        let knotParser = KnotParser("CombinedTest")
        knotParser.parse()
        XCTAssertEqual(knots, knotParser.knots)
    }
}
