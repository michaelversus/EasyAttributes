//
//  SpecificParsersTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class SpecificParsersTests: XCTestCase {

    func testIntParserSuccess() {
        let string = "12>add this font</pr12>"
        let result = intP.run(string)
        XCTAssertEqual(result.match, 12)
        XCTAssertEqual(result.rest, Substring(">add this font</pr12>"))
    }

    func testIntParserFailure() {
        let string = "<12>add this font</pr12>"
        let result = intP.run(string)
        XCTAssertEqual(result.match, nil)
        XCTAssertEqual(result.rest, Substring("<12>add this font</pr12>"))
    }
    
    func testDoubleParserSuccess() {
        let string = "12.456>add this font</pr12>"
        let result = doubleP.run(string)
        XCTAssertEqual(result.match, 12.456)
        XCTAssertEqual(result.rest, Substring(">add this font</pr12>"))
    }

    func testDoubleParserFailure() {
        let string = "<12.456>add this font</pr12>"
        let result = doubleP.run(string)
        XCTAssertEqual(result.match, nil)
        XCTAssertEqual(result.rest, Substring("<12.456>add this font</pr12>"))
    }
    
    func testCharacterParserSuccess() {
        let string = "12>add this font</pr12>"
        let result = charP.run(string)
        XCTAssertEqual(result.match, "1")
        XCTAssertEqual(result.rest, Substring("2>add this font</pr12>"))
    }
    
    func testCharacterParserFailure() {
        let string = ""
        let result = charP.run(string)
        XCTAssertEqual(result.match, nil)
        XCTAssertEqual(result.rest, Substring(""))
    }
    
    func testHexColorSuccess() {
        let string = "ebebeb>add this color</c>"
        let result = hexColor.run(string)
        XCTAssertEqual(result.match, Substring("ebebeb"))
        XCTAssertEqual(result.rest, ">add this color</c>")
    }
    
    func testHexColorFailure() {
        let string = "ebebe"
        let result = hexColor.run(string)
        XCTAssertEqual(result.match, nil)
        XCTAssertEqual(result.rest, "ebebe")
    }
    
    func testLiteralSuccess() {
        let string = "<b>add this font</b>"
        let result = literal("<b>").run(string)
        XCTAssertEqual(result.rest, "add this font</b>")
    }
    
    func testLiteralFailure() {
        let string = "<g>add this font</b>"
        let result = literal("<b>").run(string)
        XCTAssertEqual(result.rest, "<g>add this font</b>")
    }
    
    func testAlways() {
        let string = "add this font</b>"
        let result = always("<b>").run(string)
        XCTAssertEqual(result.match, "<b>")
        XCTAssertEqual(result.rest, Substring(string))
    }
    
    func testNever() {
        let string = "add this font</b>"
        let result = Parser<String>.never.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, Substring(string))
    }
}
