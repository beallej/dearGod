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
    
    // return @{@"one" : @"alpha", @"two" : @"beta", @"three" : @"gamma"};
}

- (NSData*) dicToJSON: (NSDictionary*) dic {
    return nil;
}

@end
