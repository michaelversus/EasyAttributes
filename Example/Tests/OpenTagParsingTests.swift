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
        EasyAttributes.configFonts()
    }

    func testOpenTagCustomFontSucces() {
        let string = "<pr17>add this font</pr17>"
        let result = openTag.run(string)
        XCTAssertEqual(result.match, Tag.f("PermanentMarker-Regular", 17))
        XCTAssertEqual(result.rest, "add this font</pr17>")
    }
    
    func testOpenTagColorSuccess() {
        
    }

}
