//
//  QuickAnimation.m
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

#import "QuickAnimation.h"

@implementation QuickAnimation

int imageIndex;

- (QuickAnimation*) initWithName: (NSString*) filesNames filesExtensions: (NSString*) filesExtensions numberOfFiles: (int) numberOfFiles {
    self.images = [[NSMutableArray alloc] init];
    for(int i=0; i<numberOfFiles; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@%i%@",filesNames, i, filesExtensions];
        [self.images addObject:fileName];
    }
    imageIndex = -1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(changeDisplayedImage) userInfo:nil repeats:YES];
    return [super init];
}

- (void) changeDisplayedImage {
    imageIndex++;
    if(imageIndex < self.images.count) {
        self.image = self.images[imageIndex];
    }
}

@end
