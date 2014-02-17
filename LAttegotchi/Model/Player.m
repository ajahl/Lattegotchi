//
//  Player.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Player.h"

#import "Item.h"

#define ASCPlayerName @"name"
#define ASCPlayerMoney @"money"
#define ASCPlayerLevel @"level"

@implementation Player

- (id)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _lattegotchies = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCPlayerName];
    [aCoder encodeInt:self.money forKey:ASCPlayerMoney];
    [aCoder encodeInt:self.level forKey:ASCPlayerLevel];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCPlayerName];
        _money = [aDecoder decodeIntForKey:ASCPlayerMoney];
        _level = [aDecoder decodeIntForKey:ASCPlayerLevel];
    }
    return self;
}

@end
