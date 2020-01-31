//
//  Fonts.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 12/6/19.
//

import Foundation

public struct Fonts {
    public let fonts: [String:String]
    public let fontAdaptationFactor:CGFloat?
    
    public static var shared: Fonts {
        return _shared!
    }
    
    public static var _shared: Fonts?
    
    public static func register(fonts: [String:String], fontAdaptationFactor: CGFloat? = nil) {
        _shared = Fonts(fonts: fonts, fontAdaptationFactor: fontAdaptationFactor)
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
