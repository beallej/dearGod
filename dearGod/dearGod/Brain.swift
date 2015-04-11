//
//  Brain.swift
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation

class Brain {
    let converter : JSONConverter;
    
    init()  {
        converter = JSONConverter()
    }
    
    func sendHTTPRequest(requestString: String) {
        let url = NSURL(string: requestString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.processHTTPRequest(data)
        }
        
        task.resume()
    }
    
    func processHTTPRequest(response: NSData) {
        var responseAsAString = NSString(data: response, encoding: NSUTF8StringEncoding)!
        
        // convert from NSData to NSArray containing 1 or more NSDictionary objects
        var dic : NSArray = converter.JSONToDic(response);
    }
    
    func sendNotification(message: String) {
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
        sendHTTPRequest("http://deargod.herokuapp.com/api/questions")
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