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
            let lineEnd: Character = "\n"
            let pageEnd: String
            let itemStart = String(repeating: " ", count: 2)
            let subItemStart = String(repeating: " ", count: 4)
            init() {
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
        var key = ""
        var vals = [String]()
        var started = false
        for item in list{
            let tmp = String(item)
            if tmp.hasPrefix(tag.subItemStart){
                vals.append(tmp.rm(header: tag.subItemStart).rmRegexHeader.regexExtract)
            }
            else if tmp.hasPrefix(tag.itemStart){
                if started{
                    result[key] = vals
                }
                vals.removeAll()
                started = true
                key = tmp.rm(header: tag.itemStart).rmRegexHeader.regexExtract
            }
            
        }
        
        if result.isEmpty{
            return nil
        }
        else{
            return result
        }
    }
    
    
    
    func parse(_ content: String) -> [String: [String]]?{
        
        var result = one(content)
        return result
    }
}



extension String{
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
