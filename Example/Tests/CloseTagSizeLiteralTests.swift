//
//  CloseTagSizeLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class CloseTagSizeLiteralTests: XCTestCase {

    func testCloseTagSizeLiteralBSuccess() {
        let string = "</b12> close this"
        let result = closeTagSizeLiteral.run(string)
        XCTAssertEqual(result.match, Tag.b(12))
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagSizeLiteralISuccess() {
        let string = "</i12> close this"
        let result = closeTagSizeLiteral.run(string)
        XCTAssertEqual(result.match, Tag.i(12))
        XCTAssertEqual(result.rest, " close this")
    }

    func testCloseTagSizeLiteralUnknownTagFailure() {
        let string = "</k12> close this"
        let result = closeTagSizeLiteral.run(string)
        XCTAssertEqual(result.match, Tag.none)
        XCTAssertEqual(result.rest, " close this")
    }

    func testCloseTagSizeLiteralParsingFailure() {
        let string = "/b12> close this"
        let result = closeTagSizeLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "/b12> close this")
    }

}
