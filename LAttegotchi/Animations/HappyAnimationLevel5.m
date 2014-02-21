//
//  HappyAnimation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "HappyAnimationLevel5.h"

@implementation HappyAnimationLevel5

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1L5.png",
                   @"tamatama_nomal2L5.png",
                   @"tamatama_nomal3L5.png",
                   @"tamatama_nomal4L5.png",  nil];
    }
    return self;
}

@end
