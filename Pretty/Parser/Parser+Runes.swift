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
    let qu = Parser<(B) -> B>{
        input in
        guard let (result, remainder) = lhs.parseX(input) else {
            return nil
        }
        return (curry({ _,
                        y in y })(result), remainder)
    }
    let hao: Parser<((B) -> B, B)> = qu.followed(by: rhs)
        
    let over: Parser<B> = hao.convert{ $0($1) }
    
    return over
}

/// Ignoring Right
/// ma -> mb -> ma
///
/// - Parameters:
///   - lhs: m a
///   - rhs: m b
/// - Returns: m a
func <*<A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<A> {
    
    let caca = Parser<(B) -> A> {
        input in
        guard let (result, remainder) = lhs.parseX(input) else {
            return nil
        }
        return ({ _ in result }, remainder)
    }
    let www: Parser<((B) -> A, B)> = caca.followed(by: rhs)
    return www.convert { (a: (B) -> A, b: B) -> A in
        a(b)
    }
}
// 不能确定类型，是因为不给足信息，可以存在多种解释


// 这个方法，非常的神奇
