//
//  Tags+Parsing.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

public let openTagSizeLiteral = zip(literal("<"), char, int, literal(">"))
    .map { _, c, size, _ -> Tag in
        switch c {
        case "b": return Tag.b(CGFloat(size))
        case "i": return Tag.i(CGFloat(size))
        default: return Tag.none
        }
}

public let closeTagSizeLiteral = zip(literal("</"), char, int, literal(">"))
    .map { _, c, size, _ -> Tag in
        switch c {
        case "b": return Tag.b(CGFloat(size))
        case "i": return Tag.i(CGFloat(size))
        default: return Tag.none
        }
}

public let openTag = oneOf(
    openTagSizeLiteral,
    literal("<u>").map { .u },
    literal("<n>").map { .none }
)

public let closeTag = oneOf(
    closeTagSizeLiteral,
    literal("</u>").map { .u },
    literal("</n>").map { .none },
    .never
)

public let zeroOrMoreNotLT = prefix(while: { $0 != "<" })
    .flatMap {
        $0.isEmpty ? .never : always(AttributedSubstring(tags: [.none], string: $0))
}

public let attribute = zip(openTag, zeroOrMoreNotLT, closeTag)
    .map { ot, str, ct -> AttributedSubstring in
        guard ot == ct else {
            return AttributedSubstring(tags: [.none], string: str.string)
        }
        return AttributedSubstring(tags: [ot], string: str.string)
}

public let attributeOrNestedAttribute = zip(openTag, oneOf(attribute,zeroOrMoreNotLT), closeTag)
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

public let wordOrAttribute = oneOf(attributeOrNestedAttribute, zeroOrMoreNotLT)

public let wordsOrAttributes = zeroOrMore(wordOrAttribute)

extension Array where Element == AttributedSubstring {
    public func build() -> NSAttributedString {
        return self.reduce(into: NSMutableAttributedString()) { r, attr in
            r.append(
                NSAttributedString(
                    string: String(attr.string),
                    attributes: attr.tags.attributes))
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
    public func toAttributed() -> NSAttributedString? {
        let attrStrings = wordsOrAttributes.run(self).match
        return attrStrings?.build()
    }
}

