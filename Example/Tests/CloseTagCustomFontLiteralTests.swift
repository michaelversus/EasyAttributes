//
//  CloseTagCustomFontLiteralTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class CloseTagCustomFontLiteralTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        EasyAttributes.configFonts(with: ["pr":"PermanentMarker-Regular"])
    }
    
    
    func testCloseTagCustomFontLiteralSuccess() {
        let string = "</pr17> close this"
        let result = closeTagCustomFontLiteral.run(string)
        XCTAssertEqual(result.match, Tag.f("PermanentMarker-Regular", 17, nil))
        XCTAssertEqual(result.rest, " close this")
    }
    
    func testCloseTagCustomFontLiteralUnknownTagFailure() {
        let string = "</bb17> close this"
        let result = closeTagCustomFontLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "</bb17> close this")
    }
    
    func testCloseTagCustomFontLiteralParsingFailure() {
        let string = "<bb17> close this"
        let result = closeTagCustomFontLiteral.run(string)
        XCTAssertNil(result.match)
        XCTAssertEqual(result.rest, "<bb17> close this")
    }

}
