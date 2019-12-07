//
//  AttributedString.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

public struct AttributedSubstring {
    public let tags: [Tag]
    public let string: Substring
    
    public init(tags: [Tag], string: Substring) {
        self.tags = tags
        self.string = string
    }
}

extension AttributedSubstring: Equatable {}
