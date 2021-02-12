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
            var result = [Result]()
            var remainder = input
            
            while let (element, newRemainder) = self.parseX(remainder) {
                
                result.append(element)
                remainder = newRemainder
            }
            return (result, remainder)
        }
    }
    
    
    var many: Parser<[Result]> {
        Parser<(Array<Result>) -> Array<Result>>{
            input in
            guard let (result, remainder) = self.parseX(input) else {
                return nil
            }
            return (curry{ [$0] + $1 }(result), remainder)
        }.followed(by: self._many).convert{ $0($1) }
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
