//
//  HappyAnimation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "HappyAnimationLevel4.h"

@implementation HappyAnimationLevel4

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1L4.png",
                   @"tamatama_nomal2L4.png",
                   @"tamatama_nomal3L4.png",
                   @"tamatama_nomal4L4.png",  nil];
    }
    return self;
}

@end
