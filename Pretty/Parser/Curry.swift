//
//  Curry.swift
//  RxDemo
//
//  Created by Octree on 2016/10/28.
//  Copyright © 2016年 Octree. All rights reserved.
//  

import Foundation

// 2
public func curry<T, U, V>(_ f: @escaping (T, U) -> V) -> (T) -> (U) -> V {
    
    return { x in { y in f(x, y) } }
}







