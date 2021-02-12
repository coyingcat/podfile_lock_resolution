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


// 处理右边
func *><A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<B> {
    let qu = Parser<Void>{
        input in
        guard let (_, remainder) = lhs.parseX(input) else {
            return nil
        }
        return ((), remainder)
    }
    let hao: Parser<(Void, B)> = qu.followed(by: rhs)
    
    return Parser<B>{
        input in
        guard let (result, remainder) = hao.parseX(input) else {
            return nil
        }
        return (result.1, remainder)
    }

}

/// Ignoring Right
/// ma -> mb -> ma
///
/// - Parameters:
///   - lhs: m a
///   - rhs: m b
/// - Returns: m a


// 处理左边

// 展开可以省略流程
func <*<A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<A> {
    
    let caca = Parser<A>{
        input in
        guard let (result, remainder) = lhs.parseX(input) else {
            return nil
        }
        return (result, remainder)
    }
    let www: Parser<(A)> = Parser<(A)>{
        input in
        guard let (first, reminder) = caca.parseX(input),
            let (_, newReminder) = rhs.parseX(reminder) else {
                return nil
        }
        return (first, newReminder)
    }
    return Parser<A> {
        input in
        guard let (result, remainder) = www.parseX(input) else {
            return nil
        }
        return (result, remainder)
    }
}
// 不能确定类型，是因为不给足信息，可以存在多种解释


// 这个方法，非常的神奇


// 从链式编程， 到函数式，到操作符，


// 代码风格为不直观， 开劝退



// 写代码的人，有才
