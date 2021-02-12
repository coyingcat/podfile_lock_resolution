//
//  Parser+Runes.swift
//  Pretty
//
//  Created by Octree on 2018/4/7.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Foundation

/// Ignoring Left
/// ma -> mb -> mb
///
/// - Parameters:
///   - lhs: m a
///   - rhs: m b
/// - Returns: m b
func *><A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<B> {
    return lhs.convert(curry({ _,
                               y in y })).followed(by: rhs).convert{ $0($1) }
}

/// Ignoring Right
/// ma -> mb -> ma
///
/// - Parameters:
///   - lhs: m a
///   - rhs: m b
/// - Returns: m a
func <*<A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<A > {
    let aaa: (A) -> (A) -> A = { x in { _ in x } }
    let bbb: Parser<(A) -> A> = lhs.convert({ x in { _ in x } })
    return lhs.convert(curry({ x, _ in x })).followed(by: rhs).convert{ $0($1) }
}
