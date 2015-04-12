//
//  Brain.swift
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation

class Brain {
    let converter : JSONConverter
    var myID = ""
    
    init()  {
        converter = JSONConverter()
        myID = openFile("myID", fileExtension: "txt")!
        if(myID == "") {
            askForID()
        }
    }
    
    func askQuestion(question: String) {
        if(myID != "") {
            var dic : [String:String]
            dic = ["question": question]
            postRequest("http://deargod.herokuapp.com/api/questions", requestDic: dic, requestType: RequestType.NewQuestion)
        }
    }
    
    func getAllQuestions() {
        if(myID != "") {
            getRequest("http://deargod.herokuapp.com/api/questions", requestType: RequestType.GetAllQuestions)
        }
    }
    
    func answerQuestion(questionID: String, answer: String) {
        if(myID != "") {
            var dic : [String:String]
            dic = ["answer": answer]
            postRequest("http://deargod.herokuapp.com/api/questions" + questionID, requestDic: dic, requestType: RequestType.AnswerQuestion)
        }
    }
    
    func getQuestion(questionID: String) {
        if(myID != "") {
            getRequest("http://deargod.herokuapp.com/api/questions"+questionID, requestType: RequestType.GetQuestion)
        }
    }
    
    func getQuestionToAnswer() {
        if(myID != "") {
            getRequest("http://deargod.herokuapp.com/api/questions/answer/"+myID, requestType: RequestType.GetQuestionToAnswer)
        }
    }
    
    func askForID() {
        getRequest("http://deargod.herokuapp.com/api/users/", requestType: RequestType.GetID)
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
            var err : NSErrorPointer = NSErrorPointer()
            if(requestType == RequestType.GetID) {
                if var question : NSDictionary = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers , error: err) as? NSDictionary{
                    myID = question.objectForKey("id") as! String
                    saveFile("myID", fileExtension: "txt", myID)
                }
            }
            else {
                if var question : NSArray = NSJSONSerialization.JSONObjectWithData(response, options: NSJSONReadingOptions.MutableContainers , error: err) as? NSArray{
                    if(requestType == RequestType.NewQuestion) {
                        // TODO - WE DON'T NEED THIS
                    }
                    else if(requestType == RequestType.AnswerQuestion) {
                        // TODO - WE DON'T NEED THIS
                    }
                    else if(requestType == RequestType.GetAllQuestions) {
                        NSNotificationCenter.defaultCenter().postNotificationName("checkWithBrainForTableContents", object: nil)
                    }
                    else if(requestType == RequestType.GetQuestion) {
                        // TODO - WE DON'T NEED THIS
                    }
                    else if(requestType == RequestType.GetQuestionToAnswer) {
                        // todo
                        sharedData.questionToAnswer = "insert question to answer here"
                        NSNotificationCenter.defaultCenter().postNotificationName("checkWithBrainForQuestionToAnswer", object: nil)
                    }
                }
                else {
                }
            }
        }
        else {
        }
    }
    
    func saveQuestions(questions : NSArray){
        for question in questions {
            if !(sharedData.questions.containsObject(question)){
                sharedData.questions.addObject(question)
            }
            
        }
        
        
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