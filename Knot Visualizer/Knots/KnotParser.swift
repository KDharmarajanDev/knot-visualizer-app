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
    var currImgName : String = ""
    
    var fileName : String
    
    init(_ fileName: String) {
        self.fileName = fileName
    }
    
    func parse(){
        let xmlPath : URL = Bundle.main.url(forResource: fileName, withExtension: "xml")!
        let xmlData : Data? = try? Data(contentsOf: xmlPath)
        let parser : XMLParser = XMLParser(data: xmlData!)
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currElement = elementName
        if elementName == "Knot" {
            knotStates = []
            currName = ""
            currImgName = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currElement {
        case "Knot":
            currName = string
        case "KnotState":
            knotStates.append(KnotState(string))
        case "Thumbnail":
            currImgName = string
        default:
            knotStates.append(KnotState(string))
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        knots.append(Knot(knotStates, UIImage(named: currImgName)! , currName))
    }
}
