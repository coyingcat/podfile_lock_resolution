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
    return Parser<B>{
        input in
        // 先这一步 self  parse，再下一步 other parse
        guard let (_, reminder) = lhs.parseX(input),
            let (second, newReminder) = rhs.parseX(reminder) else {
                return nil
        }
        return (second, newReminder)
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
    return Parser<(A)>{
        input in
        guard let (first, reminder) = lhs.parseX(input),
            let (_, newReminder) = rhs.parseX(reminder) else {
                return nil
        }
        return (first, newReminder)
    }
}
// 不能确定类型，是因为不给足信息，可以存在多种解释


// 这个方法，非常的神奇


// 从链式编程， 到函数式，到操作符，


// 代码风格为不直观， 开劝退



// 写代码的人，有才
