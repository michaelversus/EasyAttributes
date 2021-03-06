//
//  Tags+Parsing.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation
import UIKit

//MARK: - Open Tag

public let openTagSizeLiteral = zip(literal("<"), charP, intP, literal(">"))
    .map { _, c, size, _ -> Tag in
        switch c {
        case "s": return Tag.s(CGFloat(size))
        case "b": return Tag.b(CGFloat(size))
        case "i": return Tag.i(CGFloat(size))
        default: return Tag.none
        }
}

public let openTagLiteral = zip(literal("<"), charP, literal(">"))
    .map { _, c, _ -> Tag in
        switch c {
        case "u": return .u
        default: return .none
        }
    }

public let openTagColorLiteral = zip(literal("<"), charP, literal(":"), hexColor, literal(">"))
    .map { _, c, _, hex, _ -> Tag in
        guard let color = UIColor(hex: String(hex)) else { return .none }
        switch c {
        case "c": return .c(color)
        default: return .none
    }
}

public let openTagCustomFontLiteral = zip(literal("<"), customFont, intP, literal(">"))
    .map { _, fKey, size, _ -> Tag in
        guard let key = Fonts.shared.fonts[String(fKey)] else { return .none }
        return .f(key, CGFloat(size), Fonts.shared.fontAdaptationFactor)
    }

let zeroOrMoreNotGTPlain = prefix(while: { $0 != ">" })
    .flatMap {
        $0.isEmpty ? .never : always($0)
}

public let openTagActionLiteral = zip(literal("<"), charP, literal(":"), zeroOrMoreNotGTPlain, literal(">"))
    .map { _, c, _, actionTag, _ -> Tag in
        switch c {
        case "a": return .a(String(actionTag))
        default: return .none
        }
}

//MARK: - Close Tag

public let closeTagSizeLiteral = zip(literal("</"), charP, intP, literal(">"))
    .map { _, c, size, _ -> Tag in
        switch c {
        case "s": return Tag.s(CGFloat(size))
        case "b": return Tag.b(CGFloat(size))
        case "i": return Tag.i(CGFloat(size))
        default: return Tag.none
        }
    }

public let closeTagLiteral = zip(literal("</"), charP, literal(">"))
    .map { _, c, _ -> Tag in
        switch c {
        case "u": return .u
        case "c": return .c(nil)
        case "a": return .a(nil)
        default: return .none
        }
    }

public let closeTagCustomFontLiteral = zip(literal("</"), customFont, intP, literal(">"))
    .map { _, fKey, size, _ -> Tag in
        guard let key = Fonts.shared.fonts[String(fKey)] else { return .none }
        return .f(key, CGFloat(size), Fonts.shared.fontAdaptationFactor)
    }

//MARK: - Combine ALL

public let openTag = oneOf(
    openTagCustomFontLiteral,
    openTagColorLiteral,
    openTagActionLiteral,
    openTagSizeLiteral,
    openTagLiteral
)

public let closeTag = oneOf(
    closeTagCustomFontLiteral,
    closeTagSizeLiteral,
    closeTagLiteral,
    .never
)

public let zeroOrMoreNotLT = prefix(while: { $0 != "<" })
    .flatMap {
        $0.isEmpty ? .never : always(AttributedSubstring(tags: [.none], string: $0))
}

public let attributeP = zip(openTag, zeroOrMoreNotLT, closeTag)
    .map { ot, str, ct -> AttributedSubstring in
        guard ot == ct else {
            return AttributedSubstring(tags: [.none], string: str.string)
        }
        return AttributedSubstring(tags: [ot], string: str.string)
}

public let attributeOrNestedAttribute =
    zip(openTag,
        oneOf(attributeP,zeroOrMoreNotLT),
        closeTag)
    .map { ot, str, ct -> AttributedSubstring in
        guard ot == ct else {
            return AttributedSubstring(tags: str.tags, string: str.string)
        }
        guard str.tags != [.none] else {
            return AttributedSubstring(tags: [ot], string: str.string)
        }
        var newTags = str.tags
        newTags.append(ot)
        return AttributedSubstring(tags: newTags, string: str.string)
}

public let attributedOrDoubleNestedAttributed =
    zip(openTag,
        oneOf(attributeOrNestedAttribute,attributeP),
        closeTag)
    .map { ot, str, ct -> AttributedSubstring in
        guard ot == ct else {
            return AttributedSubstring(tags: str.tags, string: str.string)
        }
        guard str.tags != [.none] else {
            return AttributedSubstring(tags: [ot], string: str.string)
        }
        var newTags = str.tags
        newTags.append(ot)
        return AttributedSubstring(tags: newTags, string: str.string)
}

public let wordOrAttribute = oneOf(attributedOrDoubleNestedAttributed, attributeOrNestedAttribute, zeroOrMoreNotLT)

public let wordsOrAttributes = zeroOrMore(wordOrAttribute)

extension Array where Element == AttributedSubstring {
    public func build(with linkAttributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
        var location = 0
        return self.reduce(into: NSMutableAttributedString()) { r, attr in
            location += attr.string.count
            if let attributes = attr.tags.attributes, attributes.keys.contains(.link) {
                let linkTag: String = attributes[NSAttributedString.Key.link] as! String
                r.append(NSAttributedString(string: String(attr.string), attributes: linkAttributes))
                r.addAttribute(.link, value: "easy://\(linkTag)", range: NSRange(location: location - attr.string.count, length: attr.string.count))
            } else {
                r.append(
                    NSAttributedString(
                        string: String(attr.string),
                        attributes: attr.tags.attributes?.merging(linkAttributes ?? [:]) { (_, new) in new }
                    )
                )
            }
        }
    }
}

extension Array where Element == Tag {
    var attributes: [NSAttributedString.Key : Any]? {
        var dict: [NSAttributedString.Key : Any] = [:]
        self.forEach { tag in
            tag.attributes?.forEach { attr in
                dict[attr.key] = attr.value
            }
        }
        return dict
    }
}

extension String {
    public func toAttributed(with linkAttributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString? {
        let attrStrings = wordsOrAttributes.run(self).match
        return attrStrings?.build(with: linkAttributes)
    }
}
