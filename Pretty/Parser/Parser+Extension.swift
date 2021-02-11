//
//  Parser+Extension.swift
//  Pretty
//
//  Created by Octree on 2018/4/7.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Foundation


extension Parser {
    
    private var _many: Parser<[Result]> {
        
        return Parser<[Result]> {
            input in
            var result: [Result] = []
            var remainder = input
            
            while let (element, newRemainder) = self.parseX(remainder) {
                
                result.append(element)
                remainder = newRemainder
            }
            return (result, remainder)
        }
    }
    
    
    var many: Parser<[Result]> {
        tranformX(lhs: curry { [$0] + $1 }, rhs: self).followed(by: self._many).convert{ $0($1) }
    }

    
    func convert<T>(_ transform: @escaping (Result) -> T) -> Parser<T> {
        
        return Parser<T> {
            input in
            guard let (result, remainder) = self.parseX(input) else {
                return nil
            }
            return (transform(result), remainder)
        }
    }
    
    func then<B>(lhs: @escaping (Result) -> Parser<B>) -> Parser<B> {
        
        return Parser<B> {
            input in
            guard let rt = self.parseX(input) else {
                return nil
            }
            
            return lhs(rt.0).parseX(rt.1)
        }
    }
    
    func followed<A>(by other: Parser<A>) -> Parser<(Result, A)> {
        return Parser<(Result, A)>  {
            input in
            
            guard let (first, reminder) = self.parseX(input),
                let (second, newReminder) = other.parseX(reminder) else {
                    return nil
            }
            return ((first, second), newReminder)
        }
    }
    
    func or(_ other: Parser<Result>) -> Parser<Result> {
        
        return Parser {
            input in
            return self.parseX(input) ?? other.parseX(input)
        }
    }
    
    var optional: Parser<Result?> {
        
        return Parser<Result?> {
            input in
            guard let (result, remainder) = self.parseX(input) else {
                return (nil, input)
            }
            return (result, remainder)
        }
    }
}
