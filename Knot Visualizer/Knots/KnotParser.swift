//
//  KnotParser.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/30/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//
import UIKit

class KnotParser : NSObject, XMLParserDelegate {
    
    var knots : Array<Knot> = []
    var knotStates: Array<KnotState> = []
    var currElement : String = ""
    var currName : String = ""
    var currKnotStateName : String = ""
    var currImgName : String = ""
    
    var fileName : String
    
    init(_ fileName: String) {
        self.fileName = fileName
    }
    
    func parse(){
        if let xmlURL : URL = Bundle.main.url(forResource: fileName, withExtension: "xml") {
            if let parser : XMLParser = XMLParser(contentsOf: xmlURL) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currElement = elementName
        if elementName == "Knot" {
            knotStates = []
            currName = ""
            currImgName = ""
            currKnotStateName = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString : String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        switch currElement {
        case "Knot":
            currName += trimmedString
        case "KnotState":
            currKnotStateName += trimmedString
        case "Thumbnail":
            currImgName += trimmedString
        default:
            currKnotStateName += trimmedString
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Knot" {
            knots.append(Knot(knotStates, UIImage(named: currImgName)! , currName))
        } else if elementName == "KnotState" {
            knotStates.append(KnotState(currKnotStateName))
            currKnotStateName = ""
        }
    }
}
