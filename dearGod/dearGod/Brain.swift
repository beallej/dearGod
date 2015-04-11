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
    
    /*
    * This method is called after the app is opened. We are using it to test code. Remove this method before deployment!
    */
    func test() {
        sendHTTPRequest("http://deargod.herokuapp.com/api/questions")
    }
    
    /*
    * This method sends an HTTP request (requestString) and runs processHTTPRequest on the response.
    * @param the string to send to the server
    */
    func sendHTTPRequest(requestString: String) {
        let url = NSURL(string: requestString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.processHTTPRequest(data)
        }
        
        task.resume()
    }
    
    /*
    * This method sends an HTTP request (requestData) and runs processHTTPRequest on the response.
    * @param the string to send to the server
    */
    func sendHTTPRequest(requestData: NSData) {
        var requestString : NSString = NSString(data: requestData, encoding: NSUTF8StringEncoding)!
        let url = NSURL(string: requestString as String)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.processHTTPRequest(data)
        }
        
        task.resume()
    }
    
    /*
    * This method sends an HTTP request (requestData) and runs processHTTPRequest on the response.
    * @param the string to send to the server
    */
    func sendHTTPRequest(requestString: String, requestData: NSData) {
        var dataToAppend : NSString = NSString(data: requestData, encoding: NSUTF8StringEncoding)!
        var httpRequestString : String = requestString + (dataToAppend as String)
        let url = NSURL(string: httpRequestString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.processHTTPRequest(data)
        }
        
        task.resume()
    }
    
    
    
    /*
    * This method deals with responses from the server.
    * @param response the data received from the server
    */
    func processHTTPRequest(response: NSData) {
        var responseAsAString = NSString(data: response, encoding: NSUTF8StringEncoding)!
        
        // convert from NSData to NSArray containing 1 or more NSDictionary objects
        var dic : NSArray = converter.JSONToDic(response);
    }
    
    /*
    * This method returns the contents of the given file
    * @param fileName the name of the file you wish to read (excluding the extension)
    * @param fileExtension that file's extension
    * @param utf8 the encoding of the file (leave this blank for our purposes)
    * @return the contents of the file as a string
    */
    func openFile (fileName: String, fileExtension: String, utf8: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)
        var error: NSError?
        return NSFileManager().fileExistsAtPath(filePath!) ? String(contentsOfFile: filePath!, encoding: utf8, error: &error)! : nil
    }
    
    /*
    * @param fileName the name of the file you wish to write to
    * @param fileExtension that file's extension
    * @param content the string to twrite to file
    * @param utf8 the encoding of the file (leave this blank for our purposes)
    * @return whether the write was successful
    */
    func saveFile (fileName: String, fileExtension: String, _ content: String, utf8: NSStringEncoding = NSUTF8StringEncoding) -> Bool {
        var error: NSError?
        let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)
        return content.writeToFile(filePath!, atomically: true, encoding: utf8, error: &error)
    }
    
    func intToChar(input: Int) -> Character {
        return Character(UnicodeScalar(input));
    }
    
    func charToInt(input: Character) -> Int {
        let scalars = String(input).unicodeScalars;
        var integer = scalars[scalars.startIndex].value;
        return Int(integer);
    }
}