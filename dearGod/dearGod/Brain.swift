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
    
    func askQuestion(question: String) {
        var dic : [String:String]
        dic = ["question": question]
        postRequest("http://deargod.herokuapp.com/api/questions", requestDic: dic, requestType: RequestType.NewQuestion)
    }
    
    func getAllQuestions() {
        getRequest("http://deargod.herokuapp.com/api/questions", requestType: RequestType.GetAllQuestions)
    }
    
    func answerQuestion(questionID: String, answer: String) {
        var dic : [String:String]
        dic = ["answer": answer]
        postRequest("http://deargod.herokuapp.com/api/questions" + questionID, requestDic: dic, requestType: RequestType.AnswerQuestion)
    }
    
    
    func getID() {
        var dic : [String:String]
        dic = ["ip": getIP()]
        postRequest("http://deargod.herokuapp.com/api/users", requestDic: dic, requestType: RequestType.NewQuestion)
    }
    
    func getRequest(requestString: String, requestType: RequestType) {
        var httpRequestString : String = requestString
        let url = NSURL(string: httpRequestString)
        var request : NSMutableURLRequest
        request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            if let constVar = data {
                self.processHTTPRequest(data, requestType: requestType)
            }
            else {
                // data is "nil" - do nothing
            }
        }
    }
    
    
    func postRequest(requestString: String, requestDic: NSDictionary, requestType: RequestType) {
        let dic: AnyObject? = requestDic.copy();
        var httpRequestString : String = requestString
        var data = converter.dicToJSON(dic as! [String : String])
        
        let url = NSURL(string: httpRequestString)
        var request : NSMutableURLRequest
        request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        var jsonData = converter.dicToJSON(dic as! [String : String])
        request.HTTPBody = jsonData;
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            if let constVar = data {
                self.processHTTPRequest(data, requestType: requestType)
                
            }
            else {
                // data is "nil" - do nothing
            }
        }
    }
    
    
    func putRequest(requestString: String, requestDic: NSDictionary, requestType: RequestType) {
        let dic: AnyObject? = requestDic.copy();
        var httpRequestString : String = requestString
        var data = converter.dicToJSON(dic as! [String : String])
        
        let url = NSURL(string: httpRequestString)
        var request : NSMutableURLRequest
        request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "PUT"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        var jsonData = converter.dicToJSON(dic as! [String : String])
        request.HTTPBody = jsonData;
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            if let constVar = data {
                self.processHTTPRequest(data, requestType: requestType)
            }
            else {
                // data is "nil" - do nothing
            }
        }
    }
    
    /*
    * This method deals with responses from the server.
    * @param response the data received from the server
    */
    func processHTTPRequest(response: NSData, requestType: RequestType) {
        // convert from NSData to NSArray containing 1 or more NSDictionary objects

        if(response.length > 5) {
            if(requestType == RequestType.NewQuestion) {
                var err : NSErrorPointer = NSErrorPointer()
                if var question : NSArray = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers , error: err) as? NSArray{
                    
                }
            }
            else if(requestType == RequestType.AnswerQuestion) {
                var err : NSErrorPointer = NSErrorPointer()
                if var answer : NSArray = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers , error: err) as? NSArray
                {
                }
            }
            else if(requestType == RequestType.GetAllQuestions) {
                var err : NSErrorPointer = NSErrorPointer()
                if var questions = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers , error: err) as? NSArray{
                    self.saveQuestions(questions)
                }
                
                
            }
            else {
            }

        }
        else {
        }
    }
    
    func saveQuestions(questions : NSArray){
        for question in questions {
            if !sharedData.questions.containsObject(question){
                sharedData.questions.addObject(question)
            }
        }
        
    }
    
    /*
    * Finds the device's IP address
    * @return the IP address as a string
    */
    func getIP() -> String {
        let host = CFHostCreateWithName(nil,"www.google.com").takeRetainedValue();
        CFHostStartInfoResolution(host, .Addresses, nil);
        var success: Boolean = 0;
        let addresses = CFHostGetAddressing(host, &success).takeUnretainedValue() as NSArray;
        if (addresses.count > 0) {
            let theAddress = addresses[0] as! NSData;
            var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
            if getnameinfo(UnsafePointer(theAddress.bytes), socklen_t(theAddress.length), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                if let numAddress = String.fromCString(hostname) {
                    return numAddress
                }
            }
        }
        return ""
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