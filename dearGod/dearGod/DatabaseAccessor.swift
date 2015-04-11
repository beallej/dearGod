//
//  DatabaseAccessor.swift
//  dearGod
//
//  Created by Thomas Redding on 4/10/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation

class DatabaseAccessor {
    
    func sendHTTPRequest(requestString: String) {
        let url = NSURL(string: "http://deargod.herokuapp.com/api/questions")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.processHTTPRequest(data)
        }
        
        task.resume()
    }
    
    func processHTTPRequest(data: NSData) {
        var response = NSString(data: data, encoding: NSUTF8StringEncoding)!
        // println(response)
        
        // var myConverter : JSONConverter
        // myConverter.conver(data)
        
        // parseJSON(data);
        
        var stuff : JSONConverter = JSONConverter()
        var dic : NSDictionary = stuff.JSONToDic(data)
        
        var q = 5;
        q = 3;
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        return boardsDictionary
    }
}