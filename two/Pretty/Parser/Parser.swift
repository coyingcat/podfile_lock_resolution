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
            let pageEnd: String
            init() {
                sublineStart = lineStart + lineStart
                pageEnd = "\(lineEnd)\(lineEnd)"
            }
        }
        
        let tag = Tag()
        guard content.hasPrefix(tag.pageStart) else {
            return nil
        }
        let info = content.rm(header: tag.pageStart)
        guard let temp = info.components(separatedBy: tag.pageEnd).first else{
            return nil
        }
        var result = [String: [String]]()
        let list = temp.split(separator: tag.lineEnd)
        for item in list{
            let check = String(item).match(regex: #"  \"?((.+)) \("#)
                
            print(check)
        }
        
        if result.isEmpty{
            return nil
        }
        else{
            return result
        }
    }
    
    
    
    func parse(_ content: String) -> [String: [String]]?{
        
        let s = "hey ho ha"
        let pattern = "(h).*(h).*(h)"
        // our goal is capture group 3, "h" in "ha"
        let regex = try! NSRegularExpression(pattern: pattern)
        let result = regex.matches(in:s, range:NSMakeRange(0, s.utf16.count))
        let third = result[0].range(at: 3) // <-- !!
        print(third.location) // 7
        print(third.length)
         one(content)
        
        
        return nil
    }
}



extension String{
    func rm(header str: String) -> String{
        return String(dropFirst(str.count))
    }


    func match(regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: .init(rawValue: 0)) else {
            return []
        }
        let results = regex.matches(in: self, options: .init(rawValue: 0), range: NSRange(location: 0, length: count))
        
        print(results.count)
        
        
        let nsString = self as NSString
        
        return results.map {
            nsString.substring(with: $0.range)
        }
    }
}
