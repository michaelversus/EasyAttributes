//
//  Parser+map.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

extension Parser {
    func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
      return Parser<B> { str -> B? in
        self.run(&str).map(f)
      }
    }
}
