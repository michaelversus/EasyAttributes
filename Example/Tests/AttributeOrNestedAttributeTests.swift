//
//  AttributeOrNestedAttributeTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class AttributeOrNestedAttributeTests: XCTestCase {

    enum Error: Swift.Error {
        case nilError
    }
    
    override func setUp() {
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"])
    }

    func invalidTagsFailure() {
        let string = "<b12>none string</i12> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.none], string: "none string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testBParsingSuccess() {
        let string = "<b12>bold string</b12> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.b(12)], string: "bold string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testIParsingSuccess() {
        let string = "<i12>italic string</i12> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.i(12)], string: "italic string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testColorSuccess() {
        let string = "<c:ffffff>white string</c> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.rest, " after")
    }
    
    func testCustomFontSuccess() {
        let string = "<pr12>pr string</pr12> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.f("PermanentMarker-Regular", 12)], string: "pr string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testUnderlinedSuccess() {
        let string = "<u>underlined string</u> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.u], string: "underlined string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testTwoNestedFontsSuccess() {
        let string = "<b13><pr14>pr string</pr14></b13> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [ Tag.f("PermanentMarker-Regular", 14), Tag.b(13)], string: "pr string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testFontColorSuccess() throws {
        let string = "<b13><c:bbbbbb>bold color string</c></b13> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match?.string, "bold color string")
        guard let hasB = result.match?.tags.contains(Tag.b(13)) else { throw Error.nilError }
        XCTAssert(hasB)
        XCTAssertEqual(result.match?.tags.count, 2)
        XCTAssertEqual(result.rest, " after")
    }
    
    func testColorFontSuccess() throws {
        let string = "<c:bbbbbb><b13>bold color string</b13></c> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match?.string, "bold color string")
        guard let hasB = result.match?.tags.contains(Tag.b(13)) else { throw Error.nilError }
        XCTAssert(hasB)
        XCTAssertEqual(result.match?.tags.count, 2)
        XCTAssertEqual(result.rest, " after")
    }
    
    func testThreeNestedFontsFailure() {
        let string = "<i12><b13><pr14>pr string</pr14></b13></i12> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "<i12><b13><pr14>pr string</pr14></b13></i12> after")
    }
    
    func testUnknownTagFailure() {
        let string = "<k>underlined string</k> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertEqual(result.match, AttributedSubstring(tags: [Tag.none], string: "underlined string"))
        XCTAssertEqual(result.rest, " after")
    }
    
    func testParsingFailure() {
        let string = "pr14>pr string</pr14> after"
        let result = attributeOrNestedAttribute.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "pr14>pr string</pr14> after")
    }
}
