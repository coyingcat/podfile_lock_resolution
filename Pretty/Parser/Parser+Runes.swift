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
    let ccc: Parser<((A) -> A, B)> = bbb.followed(by: rhs)
    
    
    let ggg: Parser<A > = lhs.convert(curry({ x, _ in x })).followed(by: rhs).convert{ $0($1) }
    
    let ok = Parser<(A) -> A>{
        input in
        guard let (result, remainder) = lhs.parseX(input) else {
            return nil
        }
        return ({ x in { _ in x } }(result), remainder)
    }.followed(by: rhs)
    
    
    
    let one: (A) -> (A) -> A = curry({ x, _ in x })
    let two: Parser<(A) -> A> = lhs.convert(one)
    let three: Parser<((A) -> A, B)> = two.followed(by: rhs)
    
    return ggg
}
// 不能确定类型，是因为不给足信息，可以存在多种解释
