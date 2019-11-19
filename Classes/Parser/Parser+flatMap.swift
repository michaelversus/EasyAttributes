//
//  Parser+flatMap.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

extension Parser {
  func flatMap<B>(_ f: @escaping (A) -> Parser<B>) -> Parser<B> {
    return Parser<B> { str -> B? in
      let original = str
      let matchA = self.run(&str)
      let parserB = matchA.map(f)
      guard let matchB = parserB?.run(&str) else {
        str = original
        return nil
      }
      return matchB
    }
  }
}
