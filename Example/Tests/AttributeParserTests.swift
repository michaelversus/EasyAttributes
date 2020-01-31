//
//  AttributeParserTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class AttributeParserTests: XCTestCase {

    override func setUp() {
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"])
    }

    func testBoldAttributeSuccess() {
        let string = "<b12>bold string</b12> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.b(12)], string: "bold string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testItalicAttributeSuccess() {
        let string = "<i12>italic string</i12> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.i(12)], string: "italic string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testSystemAttributeSuccess() {
        let string = "<s12>system string</s12> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.s(12)], string: "system string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testUnderlinedAttributeSuccess() {
        let string = "<u>underlined string</u> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.u], string: "underlined string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testDifferentTagsFailure() {
        let string = "<i12>none string</b12> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.none], string: "none string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testColorAttributeSuccess() {
        let string = "<c:ffffff>white string</c> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.rest, " after")
    }
    
    func testCustomFontAttributeSuccess() {
        let string = "<pr12>pr string</pr12> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.f("PermanentMarker-Regular", 12, nil)], string: "pr string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testUnknownAttributeFailure() {
        let string = "<k12>some string</k12> after"
        let result = attributeP.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.none], string: "some string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testParsingAttributeFailure() {
        let string = "u>underlined string</u> after"
        let result = attributeP.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "u>underlined string</u> after")
    }

}
