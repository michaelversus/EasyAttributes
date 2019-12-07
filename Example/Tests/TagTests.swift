//
//  TagTests.swift
//  EasyAttributes_Tests
//
//  Created by MIC KARAGIORGOS on 12/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import EasyAttributes

class TagTests: XCTestCase {

    enum Error: Swift.Error {
        case nilError
    }
    
    func testTagB() throws {
        let b = Tag.b(16)
        let expectedFont = UIFont.boldSystemFont(ofSize: 16)
        guard
            let font = b.attributes?[NSAttributedString.Key.font] as? UIFont
        else { throw Error.nilError }
        XCTAssertEqual(expectedFont, font)
    }
    
    func testTagI() throws {
        let i = Tag.i(15)
        let expectedFont = UIFont.italicSystemFont(ofSize: 15)
        guard
            let font = i.attributes?[NSAttributedString.Key.font] as? UIFont
        else { throw Error.nilError }
        XCTAssertEqual(expectedFont, font)
    }
    
    func testTagCWithColor() throws {
        let c = Tag.c(.red)
        let expectedColor = UIColor.red
        guard
            let color = c.attributes?[NSAttributedString.Key.foregroundColor] as? UIColor
        else { throw Error.nilError }
        XCTAssertEqual(expectedColor, color)
    }

    func testTagCWithoutColor() throws {
        let c = Tag.c(nil)
        XCTAssertNil(c.attributes)
    }
    
    func testTagFValid() throws {
        let f = Tag.f("PermanentMarker-Regular", 14)
        guard let expectedFont = UIFont(name: "PermanentMarker-Regular", size: 14) else { throw Error.nilError }
        guard let font = f.attributes?[NSAttributedString.Key.font] as? UIFont else { throw Error.nilError }
        XCTAssertEqual(expectedFont, font)
    }
    
    func testTagFInvalid() throws {
        let f = Tag.f("dsasdsa", 14)
        let expectedFont = UIFont.systemFont(ofSize: 14)
        guard let font = f.attributes?[NSAttributedString.Key.font] as? UIFont else { throw Error.nilError }
        XCTAssertEqual(expectedFont, font)
    }
    
    func testTagU() throws {
        let u = Tag.u
        let expectedStyle = NSUnderlineStyle.styleSingle.rawValue
        guard
            let style = u.attributes?[NSAttributedString.Key.underlineStyle] as? Int
        else { throw Error.nilError }
        debugPrint(expectedStyle, style)
        XCTAssertEqual(expectedStyle, style)
    }
    
    func testTagNone() throws {
        let n = Tag.none
        XCTAssertNil(n.attributes)
    }
    
}
