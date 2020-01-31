//
//  OpenTagParsingTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class OpenTagParsingTests: XCTestCase {

    override func setUp() {
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"])
    }

    func testOpenTagCustomFontLiteralSucces() {
        let string = "<pr17>add this font</pr17>"
        let result = openTag.run(string)
        XCTAssertEqual(result.match, Tag.f("PermanentMarker-Regular", 17, nil))
        XCTAssertEqual(result.rest, "add this font</pr17>")
    }
    
    func testOpenTagColorLiteralSuccess() {
        let string = "<c:ebebeb>add this color</c>"
        let result = openTag.run(string)
        XCTAssertEqual(result.rest, "add this color</c>")
    }
    
    func testOpenTagSizeLiteralBSuccess() {
        let string = "<b13>add this font</b13>"
        let result = openTag.run(string)
        XCTAssertEqual(result.match, Tag.b(13))
        XCTAssertEqual(result.rest, "add this font</b13>")
    }
    
    func testOpenTagSizeLiteralSSuccess() {
        let string = "<s12>add this font</s12>"
        let result = openTag.run(string)
        XCTAssertEqual(result.match, Tag.s(12))
        XCTAssertEqual(result.rest, "add this font</s12>")
    }

    func testOpenTagSizeLiteralISuccess() {
        let string = "<i13>add this font</i13>"
        let result = openTag.run(string)
        XCTAssertEqual(result.match, Tag.i(13))
        XCTAssertEqual(result.rest, "add this font</i13>")
    }

    
    func testOpenTagLiteralSuccess() {
        let string = "<u>add this style</u>"
        let result = openTag.run(string)
        XCTAssertEqual(result.match, Tag.u)
        XCTAssertEqual(result.rest, "add this style</u>")
    }
    
    func testOpenTagUnknownTagFailure() {
        let string = "<bb17>add this font</bb17>"
        let result = openTag.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "<bb17>add this font</bb17>")
    }
    
    func testOpenTagParsingFailure() {
        let string = "b17>add this font</b17>"
        let result = openTag.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "b17>add this font</b17>")
    }

}
