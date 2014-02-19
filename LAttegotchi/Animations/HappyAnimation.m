//
//  HappyAnimation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "HappyAnimation.h"

@implementation HappyAnimation

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1.png",
                   @"tamatama_nomal2.png",
                   @"tamatama_nomal3.png",
                   @"tamatama_nomal4.png",  nil];
    }
    return self;
}

@end
