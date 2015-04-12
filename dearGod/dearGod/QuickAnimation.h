//
//  QuickAnimation.h
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickAnimation : UIImageView

@property NSMutableArray *imageList;
@property NSTimer *timer;

- (QuickAnimation*) initWithName: (NSString*) filesNames filesExtensions: (NSString*) filesExtensions numberOfFiles: (int) numberOfFiles;

@end
