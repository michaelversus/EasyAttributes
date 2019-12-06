//
//  EasyAttributes.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 12/6/19.
//

import Foundation

public struct EasyAttributes {
    public static func configFonts(with fontsUrl: URL? = Bundle.main.url(forResource: "Fonts", withExtension: "plist")) {
        guard let fontURL = fontsUrl else { fatalError("Fonts.plist wasn't found inside Bundle.main! If you wan't to use a differnt url please use Fonts.config(with: URL)") }
        Fonts.registerPlist(url: fontURL)
    }
}
