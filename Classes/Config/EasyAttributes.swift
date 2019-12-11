//
//  EasyAttributes.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 12/6/19.
//

import Foundation

public struct EasyAttributes {
    public static func configFonts(with fonts: [String:String]) {
        Fonts.register(fonts: fonts)
    }
}
