//
//  Player.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Player.h"
#import "Item.h"

#define ASCPlayerName @"playerName"
#define ASCPlayerMoney @"playerMoney"
#define ASCPlayerLevel @"playerLevel"
#define ASCPlayerLAttegotchies @"playerLattegotchies"
#define ASCPlayerItems @"playerItems"

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
    [aCoder encodeObject:self.lattegotchies forKey:ASCPlayerLAttegotchies];
    [aCoder encodeObject:self.items forKey:ASCPlayerItems];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCPlayerName];
        _money = [aDecoder decodeIntForKey:ASCPlayerMoney];
        _level = [aDecoder decodeIntForKey:ASCPlayerLevel];
        _lattegotchies = [aDecoder decodeObjectForKey:ASCPlayerLAttegotchies];
        _items = [aDecoder decodeObjectForKey:ASCPlayerItems];
    }
    return self;
}

- (NSArray*) getOwnedItems {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (Item* item in _items) {
        if (item.amount > 0) {
            [items addObject:item];
        }
    }
    return items;
}

- (BOOL) buyItem:(Item*)item {
    if (_money >= item.value) {
        _money -= item.value;
        item.amount++;
        return YES;
    }
    return NO;
}

@end
