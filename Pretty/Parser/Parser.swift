//
//  Parser.swift
//  MacApp
//
//  Created by Octree on 2018/4/5.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Foundation

struct Parser<Result> {
    // result 分为两种，
    // String / Character
    let parseX: (Substring) -> (Result, Substring)?
}

