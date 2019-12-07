//
//  CloseTagParsingTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class CloseTagParsingTests: XCTestCase {

    override func setUp() {
        EasyAttributes.configFonts()
    }

    func testCloseTagCustomFontLiteralSucces() {
        let string = "</pr17> close this"
        let result = closeTag.run(string)
        XCTAssertEqual(result.match, Tag.f("PermanentMarker-Regular", 17))
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagSizeLiteralBSuccess() {
        let string = "</b13> close this"
        let result = closeTag.run(string)
        XCTAssertEqual(result.match, Tag.b(13))
        XCTAssertEqual(result.rest, " close this")
    }

    func testCloseTagSizeLiteralISuccess() {
        let string = "</i13> close this"
        let result = closeTag.run(string)
        XCTAssertEqual(result.match, Tag.i(13))
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagLiteralUSuccess() {
        let string = "</u> close this"
        let result = closeTag.run(string)
        XCTAssertEqual(result.match, Tag.u)
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagLiteralCSuccess() {
        let string = "</c> close this"
        let result = closeTag.run(string)
        XCTAssertEqual(result.rest, " close this")
    }

    
    func testCloseTagUnknownTagFailure() {
        let string = "</bb17> close this"
        let result = closeTag.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "</bb17> close this")
    }
    
    func testCloseTagParsingFailure() {
        let string = "/b17> close"
        let result = closeTag.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "/b17> close")
    }
    
}
