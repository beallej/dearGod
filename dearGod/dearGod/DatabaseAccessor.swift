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
            self.processHTTPRequest(NSString(data: data, encoding: NSUTF8StringEncoding)!)
        }
        
        task.resume()
    }
    
    func processHTTPRequest(response: NSString) {
        println(response)
    }
}