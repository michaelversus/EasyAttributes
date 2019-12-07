//
//  OpenTagSizeLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class OpenTagSizeLiteralTests: XCTestCase {

    func testOpenTagSizeLiteralBSuccess() {
        let string = "<b12>add this font</b12>"
        let result = openTagSizeLiteral.run(string)
        XCTAssertEqual(result.match, Tag.b(12))
        XCTAssertEqual(result.rest, "add this font</b12>")
    }
    
    func testOpenTagSizeLiteralISuccess() {
        let string = "<i12>add this font</i12>"
        let result = openTagSizeLiteral.run(string)
        XCTAssertEqual(result.match, Tag.i(12))
        XCTAssertEqual(result.rest, "add this font</i12>")
    }
    
    func testOpenTagSizeLiteralUnknownTagFailure() {
        let string = "<k12>add this font</k12>"
        let result = openTagSizeLiteral.run(string)
        XCTAssertEqual(result.match, Tag.none)
        XCTAssertEqual(result.rest, "add this font</k12>")
    }
    
    func testOpenTagSizeLiteralParsingFailure() {
        let string = "b12>add this font</b12>"
        let result = openTagSizeLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "b12>add this font</b12>")
    }

}
