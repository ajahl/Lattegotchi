//
//  HappyAnimation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "HappyAnimationLevel1.h"

@implementation HappyAnimationLevel1

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1L1.png",
                   @"tamatama_nomal2L1.png",
                   @"tamatama_nomal3L1.png",
                   @"tamatama_nomal4L1.png",  nil];
    }
    return self;
}

@end
