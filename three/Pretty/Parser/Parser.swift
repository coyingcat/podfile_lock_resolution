//
//  Parser.swift
//  MacApp
//
//  Created by Octree on 2018/4/5.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Foundation

struct Tag{
    let pageStart = "PODS:\n"
    let lineEnd: Character = "\n"
    let pageEnd: String
    let itemStart = String(repeating: " ", count: 2)
    let subItemStart = String(repeating: " ", count: 4)
    init() {
        pageEnd = String(repeating: "\(lineEnd)", count: 2)
    }
}


struct Parser {
    
    func parse(_ content: String) -> [String: [String]]?{
        
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
        let cnt = list.count
        var i = 0
        while i < cnt {
            var tmp = String(list[i])
            var key: String?
            var vals = [String]()
            if tmp.isItem{
                key = tmp.rm(header: tag.itemStart).word
                i += 1
            }
            var stay = true
            while stay, i < cnt {
                tmp = String(list[i])
                if tmp.isSubitem{
                    vals.append(tmp.rm(header: tag.subItemStart).word)
                    i += 1
                }
                else{
                    stay = false
                }
            }
            if let k = key{
                result[k] = vals
            }
            else{
                return nil
            }
        }

        if result.isEmpty{
            return nil
        }
        else{
            return result
        }
    }
}



extension String{
    
    var isItem: Bool{
        let tag = Tag()
        return hasPrefix(tag.itemStart) && (hasPrefix(tag.subItemStart) == false)
    }
    
    var isSubitem: Bool{
        let tag = Tag()
        return hasPrefix(tag.subItemStart)
    }
    
    
    var word: String{
        rmRegexHeader.regexExtract
    }
    
    
    func rm(header str: String) -> String{
        return String(dropFirst(str.count))
    }

    
    var rmRegexHeader: String{
        if let tmp = match(regex: #"- "?"#){
            return String(dropFirst(tmp.count))
        }
        else{
            return self
        }
    }
    
    
    var regexExtract: String{
        if let tmp = match(regex: #"[^\s]+"#){
            return tmp
        }
        else{
            return self
        }
    }
    
    func match(regex: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            return nil
        }
        let results = regex.matches(in: self, range: NSRange(location: 0, length: utf8.count))
        let nsString = self as NSString
        if let first = results.first{
            return nsString.substring(with: first.range)
        }
        else{
            return nil
        }
    }
}
