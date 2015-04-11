//
//  JSONConverter.h
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONConverter : NSObject

- (NSArray*) JSONToDic: (NSData*) data;
- (NSData*) dicToJSON: (NSDictionary*) dic;

@end
