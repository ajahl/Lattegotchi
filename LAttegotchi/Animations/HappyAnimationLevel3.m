//
//  HappyAnimation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "HappyAnimationLevel3.h"

@implementation HappyAnimationLevel3

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1L3.png",
                   @"tamatama_nomal2L3.png",
                   @"tamatama_nomal3L3.png",
                   @"tamatama_nomal4L3.png",  nil];
    }
    return self;
}

@end
