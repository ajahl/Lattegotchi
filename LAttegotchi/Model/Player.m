//
//  Player.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Player.h"

#import "Item.h"

@implementation Player

- (id)init
{
    self = [super init];
    if (self) {
        _items = [NSArray arrayWithObject:0];
        _lattegotchies = [NSArray arrayWithObject:0];
    }
    return self;
}

@end
