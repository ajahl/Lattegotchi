//
//  HappyAnimation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "HappyAnimationLevel2.h"

@implementation HappyAnimationLevel2

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1L2.png",
                   @"tamatama_nomal2L2.png",
                   @"tamatama_nomal3L2.png",
                   @"tamatama_nomal4L2.png",  nil];
    }
    return self;
}

@end
