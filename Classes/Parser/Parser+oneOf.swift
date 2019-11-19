//
//  Parser+oneOf.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

func oneOf<A>(_ ps: Parser<A>...) -> Parser<A> {
    return Parser<A> { str -> A? in
        for p in ps {
            if let match = p.run(&str) {
                return match
            }
        }
        return nil
    }
}
