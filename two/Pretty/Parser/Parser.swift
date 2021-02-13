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
            if let tmpSubitem = String(item).match(regex: #"    \"?(.+) \("#){
                vals.append(tmpSubitem)
            }
            else if let tmpItem = String(item).match(regex: #"  \"?(.+) \("#){
                if started{
                    result[key] = vals
                }
                vals.removeAll()
                started = true
                key = tmpItem
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
        result?.forEach({ (key: String, value: [String]) in
            print(key)
            print(value)
            print("\n\n\n")
        })
        return nil
    }
}



extension String{
    func rm(header str: String) -> String{
        return String(dropFirst(str.count))
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
