//
//  CloseTagLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class CloseTagLiteralTests: XCTestCase {

    func testCloseTagLiteralUSuccess() {
        let string = "</u> close this"
        let result = closeTagLiteral.run(string)
        XCTAssertEqual(result.match, Tag.u)
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagLiteralCSuccess() {
        let string = "</c> close this"
        let result = closeTagLiteral.run(string)
        XCTAssertNotNil(result.match)
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagLiteralUnknownTagFailure() {
        let string = "</k> close this"
        let result = closeTagLiteral.run(string)
        XCTAssertEqual(result.match, Tag.none)
        XCTAssertEqual(result.rest, " close this")
    }

    func testCloseTagLiteralParsingFailure() {
        let string = "/u> close this"
        let result = closeTagLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "/u> close this")
    }

}
