//
//  Fonts.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 12/6/19.
//

import Foundation

public struct Fonts: Decodable {
    public let fonts: [String:String]
    
    public static let shared: Fonts = {
        return _shared!
    }()
    
    public static var _shared: Fonts?
    
    public static func registerPlist(url: URL) {
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        _shared = try! decoder.decode(Fonts.self, from: data)
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
