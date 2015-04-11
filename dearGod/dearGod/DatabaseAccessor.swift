//
//  DatabaseAccessor.swift
//  dearGod
//
//  Created by Thomas Redding on 4/10/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation

class DatabaseAccessor {
    
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
}