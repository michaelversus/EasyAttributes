//
//  ZeroOrMoreNotLTParsing.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class ZeroOrMoreNotLTParsing: XCTestCase {

    func testParserSuccess() {
        let string = "string until < here"
        let result = zeroOrMoreNotLT.run(string)
        let expectedAttr = AttributedSubstring(tags: [.none], string: "string until ")
        XCTAssertEqual(result.match, expectedAttr)
        XCTAssertEqual(result.rest, "< here")
    }
    
    func testParserWithoutLT() {
        let string = "string without lt"
        let result = zeroOrMoreNotLT.run(string)
        let expectedAttr = AttributedSubstring(tags: [.none], string: "string without lt")
        XCTAssertEqual(result.match, expectedAttr)
        XCTAssertEqual(result.rest, "")
    }

}
