//
//  IosCommunicator.swift
//  dearGod
//
//  Created by Thomas Redding on 4/10/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation

class IosCommunicator {
    func sendNotification() {
        // todo
    }
    
    func test() {
        /*
        var c = intToChar(1024)
        println("{" + String(c) + "}")
        println("{" + String(charToInt(c)) + "}")
        
        
        let contents = openFile("userCode", fileExtension: "txt")
        print("(")
        print(contents)
        println(")")
        
        saveFile("userCode", fileExtension: "txt", "apples are better")
        
        let contents2 = openFile("userCode", fileExtension: "txt")
        print("[")
        print(contents2)
        println("]")
        */
    }
    
    func intToChar(input: Int) -> Character {
        return Character(UnicodeScalar(input));
    }
    
    func charToInt(input: Character) -> Int {
        let scalars = String(input).unicodeScalars;
        var integer = scalars[scalars.startIndex].value;
        return Int(integer);
    }
    
    func openFile (fileName: String, fileExtension: String, utf8: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)
        var error: NSError?
        return NSFileManager().fileExistsAtPath(filePath!) ? String(contentsOfFile: filePath!, encoding: utf8, error: &error)! : nil
    }
    func saveFile (fileName: String, fileExtension: String, _ content: String, utf8: NSStringEncoding = NSUTF8StringEncoding) -> Bool {
        var error: NSError?
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)
        return content.writeToFile(filePath!, atomically: true, encoding: utf8, error: &error)
    }
}