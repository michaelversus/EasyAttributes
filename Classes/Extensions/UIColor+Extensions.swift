//
//  UIColor+Extensions.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/27/19.
//

import Foundation

extension UIColor {
    convenience init?(hex: String) {
        guard hex.count == 6 else { return nil }
        let r, g, b, a: CGFloat
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255

            self.init(red: r, green: g, blue: b, alpha: a)
            return
        }
    
        return nil
    }
}
