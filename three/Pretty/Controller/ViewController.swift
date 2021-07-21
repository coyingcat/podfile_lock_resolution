//
//  ViewController.swift
//  Pretty
//
//  Created by Octree on 2018/4/5.
//  Copyright © 2018年 Octree. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer?.backgroundColor = NSColor.red.cgColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleOpenFile(notification:)), name: NSNotification.Name(rawValue: OCTOpenFileNotification), object: nil)
        FileName = "/Users/jzd/Movies/podfile_lock_resolution/three/Pretty/Resource/one.json"
        if FileName.count > 0 {
            parse(file: FileName)
        }
    }
    

    
    @objc func handleOpenFile(notification: Notification) {
        
        guard let filename = notification.object as? String else {
            return
        }
        parse(file: filename)
    }
    
    
    
    
    
    
    func parse(file name: String) {
        
        if name.hasSuffix(".json") {
            handle(file: name)
        }
    }
    
    
    
    
    
    func handle(file name: String) {
        do {
            let content = try String(contentsOfFile: name, encoding: .utf8)
            let myStrings = content.components(separatedBy: .newlines)
            
            var result = [String]()
            
            
            
            for ln in myStrings{
                
                
                if ln.contains("\""){
                    
                    let cakes = ln.components(separatedBy: ":")
                    cakes.forEach {
                        print($0)
                    }
                    print("\n\n\n\n\n")
                    var onePiece: String?
                    print(cakes.count)
                    if cakes.count > 1, let key = cakes[0].lean.k{
                        
                        onePiece = "let "
                      //  print(cakes[0])
                        onePiece?.append(key)
                        
                        onePiece?.append(":  ")
                        
                        let val = cakes[1].lean
                        
                        if Int(val) == nil{
                            onePiece?.append("String")
                        }
                        else{
                            onePiece?.append("Int")
                        }
                    }
                    
                    if let info = onePiece{
                        
                        result.append(info)
                    }

                }
                
                
                
            }
            
            
            print("\n\n\n\n\n")
            result.forEach {
                print($0)
            }
            print("\n\n\n\n\n")
        } catch {
            
            alert(title: "Error", msg: error.localizedDescription)
        }
    }
    
    

    
    
    func alert(title: String, msg: String) {

        
        let alert = NSAlert()
        
        
        alert.addButton(withTitle: "Ok")
        alert.messageText = title
        alert.informativeText = msg
        alert.alertStyle = .warning
        alert.runModal()
    }

}




extension String{
    
    var k: String?{
            let ret = groups(for: "^\"(.+)\"$")
            //      print(ret)
            
            if ret.count > 0, ret[0].count > 1{
                return ret[0][1]
            }
            else{
                return nil
            }
    }
    

    func groups(for regexPattern: String) -> [[String]] {
       do {
           let text = self
           let regex = try NSRegularExpression(pattern: regexPattern)
           let matches = regex.matches(in: text,
                                       range: NSRange(text.startIndex..., in: text))
           return matches.map { match in
               return (0..<match.numberOfRanges).map {
                   let rangeBounds = match.range(at: $0)
                   guard let range = Range(rangeBounds, in: text) else {
                       return ""
                   }
                   return String(text[range])
               }
           }
       } catch let error {
           print("invalid regex: \(error.localizedDescription)")
           return []
       }
   }
    
    
    var lean: String{
        replacingOccurrences(of: " ", with: "")
    }
    
    
}



