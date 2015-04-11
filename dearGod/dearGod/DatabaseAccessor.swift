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
        println(response)
        
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&parseError)
        
        if let topApps = parsedObject as? NSDictionary {
            if let feed = topApps["feed"] as? NSDictionary {
                if let apps = feed["entry"] as? NSArray {
                    if let firstApp = apps[0] as? NSDictionary {
                        if let imname = firstApp["im:name"] as? NSDictionary {
                            if let appName = imname["label"] as? NSString {
                                //3
                                println("Optional Binding: \(appName)")
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
        
        var quail = 52;
        quail = 13;
    }
}