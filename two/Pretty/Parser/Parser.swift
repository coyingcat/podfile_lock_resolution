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
            let pageStart: String
            let lineStart = "  "
            let sublineStart: String
            let lineEnd = "\n"
            let split = "DEPENDENCIES:"
            init() {
                pageStart = "PODS:" + lineEnd
                sublineStart = lineStart + lineStart
            }
        }
        let tag = Tag()
        guard content.hasPrefix(tag.pageStart) else {
            return nil
        }
        var info = content.rm(header: tag.pageStart)
        
        var i = 0
        let total = info.count

        var result = [String: [String]]()

        while i < total {
            
            let endIndex = i + target.start.count - 1
            if endIndex >= total{
                break
            }
            
            if let temp = info[i...endIndex], temp == target.start{

                var bracketCount = 0
                
                i += target.start.count - 1
                var beginIndex = 0
                while i < total {
                    switch info[i] {
                    case target.second:
                        if bracketCount == 0{
                            beginIndex = i
                        }
                        bracketCount += 1
                    case target.end:
                        bracketCount -= 1
                        if bracketCount == 0{
                            result.append(info[(beginIndex+1)...(i-1)] ?? "")
                        }
                    default:
                        ()
                    }
                    i += 1
                }
                
            }
            i += 1
        }
        return result

        
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
