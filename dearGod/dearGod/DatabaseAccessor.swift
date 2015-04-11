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
        
        var converter : JSONConverter = JSONConverter()
        
        var dic : Dictionary = converter.JSONToDic(data);
        
        
        
        
        var quail = 52;
        quail = 13;
    }
}