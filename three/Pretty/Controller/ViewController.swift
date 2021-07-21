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
        

        NotificationCenter.default.addObserver(self, selector: #selector(self.handleOpenFile(notification:)), name: NSNotification.Name(rawValue: OCTOpenFileNotification), object: nil)
     //   FileName = "/Users/jzd/Downloads/Lumiere/Podfile.lock"
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
            let string = try String(contentsOfFile: name, encoding: .utf8)
            
            
            
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

