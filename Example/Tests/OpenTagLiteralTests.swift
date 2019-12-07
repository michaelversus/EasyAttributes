//
//  OpenTagLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class OpenTagLiteralTests: XCTestCase {

    func testOpenTagLiteralSuccess() {
        let string = "<u>add this style</u>"
        let result = openTagLiteral.run(string)
        XCTAssertEqual(result.match, Tag.u)
        XCTAssertEqual(result.rest, "add this style</u>")
    }
    
    func testOpenTagLiteralUnknownTagFailure() {
        let string = "<k>add this style</k>"
        let result = openTagLiteral.run(string)
        XCTAssertEqual(result.match, Tag.none)
        XCTAssertEqual(result.rest, "add this style</k>")
    }
    
    func testOpenTagLiteralParsingFailure() {
        let string = "k>add this style</k>"
        let result = openTagLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "k>add this style</k>")
    }

}
