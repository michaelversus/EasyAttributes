//
//  Tag.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//
import UIKit

public enum Tag {
    case s(CGFloat)
    case b(CGFloat)
    case i(CGFloat)
    case c(UIColor?)
    case f(String, CGFloat, CGFloat?)
    case u
    case none
    
    public var attributes: [NSAttributedString.Key: Any]? {
        switch self {
        case .s(let size):
            return [.font: UIFont.systemFont(ofSize: size)]
        case .b(let size):
            return [.font: UIFont.boldSystemFont(ofSize: size)]
        case .i(let size):
            return [.font: UIFont.italicSystemFont(ofSize: size)]
        case .c(let color):
            guard let color = color else { return nil }
            return [.foregroundColor: color]
        case .f(let fName, let size, let adaptF):
            if let adaptF = adaptF {
                return [.font: UIFont(name: fName, size: size * adaptF) ?? UIFont.systemFont(ofSize: size * adaptF)]
            } else {
                return [.font: UIFont(name: fName, size: size) ?? UIFont.systemFont(ofSize: size)]
            }
        case .u:
            return [.underlineStyle: NSUnderlineStyle.single.rawValue]
        case .none: return nil
        }
    }
}

extension Tag: Equatable {
    public static func ==(lhs: Tag, rhs: Tag) -> Bool {
        switch (lhs, rhs) {
        case (let .s(lhsSize), let .s(rhsSize)):
            return lhsSize == rhsSize
        case (let .b(lhsSize), let .b(rhsSize)):
            return lhsSize == rhsSize
        case (let .i(lhsSize), let .i(rhsSize)):
            return lhsSize == rhsSize
        case (let .c(lhsColor), let .c(rhsColor)):
            return lhsColor != nil && rhsColor == nil
        case (let .f(lhsFName, lhsSize, lhsAdaptF), let .f(rhsFName, rhsSize, rhsAdaptF)):
            return lhsFName == rhsFName && lhsSize == rhsSize && lhsAdaptF == rhsAdaptF
        case (.u, .u):
            return true
        case (.none, .none):
            return true
        default:
            return false
        }
    }
}
