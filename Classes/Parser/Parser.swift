//
//  Parser.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

public struct Parser<A> {
    public let run: (inout Substring) -> A?
}

extension Parser {
  public func run(_ str: String) -> (match: A?, rest: Substring) {
    var str = str[...]
    let match = self.run(&str)
    return (match, str)
  }
}

public func prefix(while p: @escaping (Character) -> Bool) -> Parser<Substring> {
    return Parser<Substring> { str in
        let prefix = str.prefix(while: p)
        str.removeFirst(prefix.count)
        return prefix
    }
}
