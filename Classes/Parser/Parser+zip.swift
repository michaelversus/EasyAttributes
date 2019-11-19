//
//  Parser+zip.swift
//  EasyAttributes
//
//  Created by MIC KARAGIORGOS on 11/17/19.
//

import Foundation

func zip<A, B>(_ a: Parser<A>, _ b: Parser<B>) -> Parser<(A, B)> {
  return Parser<(A, B)> { str -> (A, B)? in
    let original = str
    guard let matchA = a.run(&str) else { return nil }
    guard let matchB = b.run(&str) else {
      str = original
      return nil
    }
    return (matchA, matchB)
  }
}

func zip<A, B, C>(
  _ a: Parser<A>,
  _ b: Parser<B>,
  _ c: Parser<C>
  ) -> Parser<(A, B, C)> {
  return zip(a, zip(b, c))
    .map { a, bc in (a, bc.0, bc.1) }
}

func zip<A, B, C, D>(
  _ a: Parser<A>,
  _ b: Parser<B>,
  _ c: Parser<C>,
  _ d: Parser<D>
  ) -> Parser<(A, B, C, D)> {
  return zip(a, zip(b, c, d))
    .map { a, bcd in (a, bcd.0, bcd.1, bcd.2) }
}

func zip<A, B, C, D, E>(
  _ a: Parser<A>,
  _ b: Parser<B>,
  _ c: Parser<C>,
  _ d: Parser<D>,
  _ e: Parser<E>
  ) -> Parser<(A, B, C, D, E)> {

  return zip(a, zip(b, c, d, e))
    .map { a, bcde in (a, bcde.0, bcde.1, bcde.2, bcde.3) }
}

func zip<A, B, C, D, E, F>(
  _ a: Parser<A>,
  _ b: Parser<B>,
  _ c: Parser<C>,
  _ d: Parser<D>,
  _ e: Parser<E>,
  _ f: Parser<F>
  ) -> Parser<(A, B, C, D, E, F)> {
  return zip(a, zip(b, c, d, e, f))
    .map { a, bcdef in (a, bcdef.0, bcdef.1, bcdef.2, bcdef.3, bcdef.4) }
}

func zip<A, B, C, D, E, F, G>(
  _ a: Parser<A>,
  _ b: Parser<B>,
  _ c: Parser<C>,
  _ d: Parser<D>,
  _ e: Parser<E>,
  _ f: Parser<F>,
  _ g: Parser<G>
  ) -> Parser<(A, B, C, D, E, F, G)> {
  return zip(a, zip(b, c, d, e, f, g))
    .map { a, bcdefg in (a, bcdefg.0, bcdefg.1, bcdefg.2, bcdefg.3, bcdefg.4, bcdefg.5) }
}
