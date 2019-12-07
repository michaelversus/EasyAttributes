//
//  CustomFontParserTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class CustomFontParserTests: XCTestCase {

    func testValidString() {
        EasyAttributes.configFonts()
        
        let string = "pr12>add this font</pr12>"
        let result = customFont.run(string)
        XCTAssertEqual(result.match, Substring("pr"))
        XCTAssertEqual(result.rest, Substring("12>add this font</pr12>"))
    }

}
