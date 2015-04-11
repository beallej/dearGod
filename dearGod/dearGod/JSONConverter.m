//
//  JSONConverter.m
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

#import "JSONConverter.h"

@implementation JSONConverter

- (NSDictionary*) JSONToDic: (NSData*) data {
    NSDictionary *dic = @{@"lame" : @"quails"};
    return dic;
    /*
    NSError* error;
    // If response JSON starts with {}, it represents dictionary
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return dicData;
    */
}

- (NSData*) dicTOJSON: (NSDictionary*) dic {
    return nil;
}

@end
