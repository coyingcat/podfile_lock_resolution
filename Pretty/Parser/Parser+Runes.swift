//
//  Parser+Runes.swift
//  Pretty
//
//  Created by Octree on 2018/4/7.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Foundation


/// Functor Operator
/// a -> b -> m a -> m b
///
/// - Parameters:
///   - lhs: a -> b
///   - rhs: m a
/// - Returns: m b
func tranformX<A, B>(lhs: @escaping (A) -> B, rhs: Parser<A>) -> Parser<B> {
    return rhs.convert(lhs)
}


/// Ignoring Left
/// ma -> mb -> mb
///
/// - Parameters:
///   - lhs: m a
///   - rhs: m b
/// - Returns: m b
func *><A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<B> {
    return tranformX(lhs: curry({ _,
                                  y in y }), rhs: lhs).followed(by: rhs).convert{ $0($1) }
}

/// Ignoring Right
/// ma -> mb -> ma
///
/// - Parameters:
///   - lhs: m a
///   - rhs: m b
/// - Returns: m a
func <*<A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<A > {
    return  tranformX(lhs: curry({ x, _ in x }), rhs: lhs).followed(by: rhs).convert{ $0($1) }
}


