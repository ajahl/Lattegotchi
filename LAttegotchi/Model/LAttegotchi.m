//
//  LAttegotchi.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "LAttegotchi.h"

@implementation LAttegotchi

- (id)init
{
    self = [super init];
    if (self) {
        _wishes = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
