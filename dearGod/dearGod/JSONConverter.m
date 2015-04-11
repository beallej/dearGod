//
//  JSONConverter.m
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

#import "JSONConverter.h"

@implementation JSONConverter

- (NSObject*) JSONToDic: (NSData*) data {
    NSError* error=nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return dic;
}

- (NSData*) dicToJSON: (NSDictionary*) dic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return jsonData;
}

@end
