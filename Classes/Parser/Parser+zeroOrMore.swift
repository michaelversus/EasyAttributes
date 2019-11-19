//
//  Parser+zeroOrMore.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation


func zeroOrMore<A>(
    _ p: Parser<A>,
    seperatedBy s: Parser<Void>
    ) -> Parser<[A]> {
    return Parser<[A]> { str in
        var rest = str
        var matches: [A] = []
        while let match = p.run(&str) {
            rest = str
            matches.append(match)
            if s.run(&str) == nil {
                return matches
            }
        }
        str = rest
        return matches
    }
}

func zeroOrMore<A>(
    _ p: Parser<A>
) -> Parser<[A]> {
    return Parser<[A]> { str in
        var matches: [A] = []
        while let match = p.run(&str) {
            matches.append(match)
            guard !str.isEmpty else { break }
        }
        return matches
    }
}
