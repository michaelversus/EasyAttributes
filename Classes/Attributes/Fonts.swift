//
//  Fonts.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 12/6/19.
//

import Foundation

public struct Fonts {
    public let fonts: [String:String]
    
    public static let shared: Fonts = {
        return _shared!
    }()
    
    public static var _shared: Fonts?
    
    public static func register(fonts: [String:String]) {
        _shared = Fonts(fonts: fonts)
    }
}

public let customFont = Parser<Substring> { str in
    var match: Substring? = nil
    guard Fonts._shared != nil else { return nil }
    for key in Fonts.shared.fonts.keys {
        if str.hasPrefix(key) {
            match = Substring(key)
            str.removeFirst(key.count)
            break
        }
    }
    return match
}
