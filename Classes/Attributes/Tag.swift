//
//  Tag.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//
import UIKit

public enum Tag: Equatable {
    case b(CGFloat)
    case i(CGFloat)
    case u
    case none
    
    public var attributes: [NSAttributedString.Key: Any]? {
        switch self {
        case .b(let size):
            return [.font: UIFont.boldSystemFont(ofSize: size)]
        case .i(let size):
            return [.font: UIFont.italicSystemFont(ofSize: size)]
        case .u:
            return [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        case .none: return nil
        }
    }
    
    public static func ==(lhs: Tag, rhs: Tag) -> Bool {
        switch (lhs, rhs) {
        case (let .b(lhsSize), let .b(rhsSize)):
            return lhsSize == rhsSize
        case (let .i(lhsSize), let .i(rhsSize)):
            return lhsSize == rhsSize
        case (.u, .u):
            return true
        case (.none, .none):
            return true
        default:
            return false
        }
    }
}
