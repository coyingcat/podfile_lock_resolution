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
            print(item)
            let check = String(item).regex(pattern: "  \"?(.+) \\(?.+\\)")
            // print(check)
            
            
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


  func regex(pattern: String) -> [String]?{
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        let all = NSRange(location: 0, length: count)
        var matches = [String]()
        regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
            (result : NSTextCheckingResult?, _, _) in
              if let r = result {
                    let nsstr = self as NSString
                    let result = nsstr.substring(with: r.range) as String
                    matches.append(result)
              }
        }
        return matches
    } catch {
        return nil
    }
  }
}
