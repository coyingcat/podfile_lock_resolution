//
//  Parser.swift
//  MacApp
//
//  Created by Octree on 2018/4/5.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Foundation


struct Parser {
    
    func one(_ content: String) -> [String: [String]]?{
        struct Tag{
            let pageStart = "PODS:\n"
            let lineStart = "  "
            let sublineStart: String
            let lineEnd: Character = "\n"
            init() {
                sublineStart = lineStart + lineStart
            }
        }
        let tag = Tag()
        guard content.hasPrefix(tag.pageStart) else {
            return nil
        }
        let info = content.rm(header: tag.pageStart)
        let list = info.split(separator: tag.lineEnd)
        var result = [String: [String]]()
        for item in list{
            
        }
        return nil
    }
    
    
    
    func parse(_ content: String) -> [String: [String]]?{
        
        
        one(content)
        
        
        return nil
    }
}



extension String{
    func rm(header str: String) -> String{
        return String(dropFirst(str.count))
    }
}
