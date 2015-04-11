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
        let err = NSError();
        let url = NSURL(string: requestString);
        var postData = "";
        var postLength = 0;
        let theRequest = NSMutableURLRequest(URL: url!);
        theRequest.addValue("text/plain; charset=utf-8", forHTTPHeaderField:"Content-Type");
        // TODO
    }
    
/*
    - (NSString*)sendBEAHTTPRequest: (NSString*) requestString {
    NSMutableString* str = [[NSMutableString alloc] initWithString:@"http://www.bea.gov/api/data?&UserID=D24BD2F4-5C05-4460-BD65-D1378571BF8C&"];
    [str appendString:requestString];
    NSString* rtn = [self sendHTTPRequest:str];
    return rtn;
    }
    
    - (NSString*)sendHTTPRequest: (NSString*) requestString {
    NSError *err;
    NSURL *url = [NSURL URLWithString:requestString];
    NSString *postData = @"";
    NSString *postLength = [NSString stringWithFormat:@"%d",((int) [postData length])];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest addValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:@"Get"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPBody: [postData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&err];
    if(!responseData) {
    NSLog(@"Connection Error: %@", [err localizedDescription]);
    return NULL;
    }
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    }
*/
}