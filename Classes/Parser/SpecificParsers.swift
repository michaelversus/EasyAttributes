//
//  SpecificParsers.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

public let intP = Parser<Int> { str in
  let prefix = str.prefix(while: { ("0"..."9").contains($0) })
  let match = Int(prefix)
  str.removeFirst(prefix.count)
  return match
}

public let doubleP = Parser<Double> { str in
  let prefix = str.prefix(while: { ("0"..."9").contains($0) || $0 == "." })
  let match = Double(prefix)
  str.removeFirst(prefix.count)
  return match
}

public let charP = Parser<Character> { str in
  guard !str.isEmpty else { return nil }
  return str.removeFirst()
}

public let hexColor = Parser<Substring> { str in
    guard str.count >= 6 else { return nil }
    let match = str.prefix(6)
    str.removeFirst(6)
    return match
}

public func literal(_ p: String) -> Parser<Void> {
  return Parser<Void> { str in
    guard str.hasPrefix(p) else { return nil }
    str.removeFirst(p.count)
    return ()
  }
}

public func always<A>(_ a: A) -> Parser<A> {
  return Parser<A> { _ in a }
}

extension Parser {
  public static var never: Parser {
    return Parser { _ in nil }
  }
}

public let zeroOrMoreSpaces = prefix(
    while: { $0 == " " })
    .map { _ in () }

public let oneOrMoreSpaces = prefix(
    while: { $0 == " " })
    .flatMap {
        $0.isEmpty ? .never : always(())
}

public let commaOrNewline = charP
    .flatMap {
        $0 == "," || $0 == "\n" ? always(()) : .never
}
