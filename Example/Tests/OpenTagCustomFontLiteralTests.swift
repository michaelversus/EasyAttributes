//
//  OpenTagCustomFontLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class OpenTagCustomFontLiteralTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"])
    }
    
    
    func testOpenTagCustomFontLiteralSuccess() {
        let string = "<pr17>add this font</pr17>"
        let result = openTagCustomFontLiteral.run(string)
        XCTAssertEqual(result.match, Tag.f("PermanentMarker-Regular", 17, nil))
        XCTAssertEqual(result.rest, "add this font</pr17>")
    }
    
    func testOpenTagCustomFontLiteralUnknownTagFailure() {
        let string = "<bb17>add this font</bb17>"
        let result = openTagCustomFontLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "<bb17>add this font</bb17>")
    }
    
    func testOpenTagCustomFontLiteralParsingFailure() {
        let string = "bb17>add this font</bb17>"
        let result = openTagCustomFontLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "bb17>add this font</bb17>")
    }
    
}
