//
//  OpenTagColorLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class OpenTagColorLiteralTests: XCTestCase {

    func testOpenTagColorLiteralSuccess() throws {
        let string = "<c:ebebeb>add this color</c>"
        let result = openTagColorLiteral.run(string)
        XCTAssertEqual(result.rest, "add this color</c>")
    }

    func testOpenTagColorLiteralParsingLiteralFailure() {
        let string = "<c;ebebeb>add this color</c>"
        let result = openTagColorLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "<c;ebebeb>add this color</c>")
        
        let string2 = "c:ebebeb>add this color</c>"
        let result2 = openTagColorLiteral.run(string2)
        XCTAssertNil(result2.match)
        XCTAssertEqual(result2.rest, "c:ebebeb>add this color</c>")
    }
    
    func testOpenTagColorLiteralParsingHexFailure() {
        let string = "<c:ebebe>add this color</c>"
        let result = openTagColorLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "<c:ebebe>add this color</c>")
    }
    
    func testOpenTagColorLiteralUnknownTagFailure() {
        let string = "<k:ebebeb>add this color</k>"
        let result = openTagColorLiteral.run(string)
        XCTAssertEqual(result.match, Tag.none)
        XCTAssertEqual(result.rest, "add this color</k>")
    }

}
