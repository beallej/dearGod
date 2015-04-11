//
//  JSONConverter.m
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

#import "JSONConverter.h"

@implementation JSONConverter

- (NSArray*) JSONToDic: (NSData*) data {
    NSArray *rtn = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return rtn;
}

- (NSData*) dicToJSON: (NSDictionary*) dic {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    return jsonData;
}

@end
