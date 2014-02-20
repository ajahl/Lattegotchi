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
        _level = 1;
        _items = [[NSMutableDictionary alloc] init];
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

- (NSDictionary*) getOwnedItems {
    NSMutableDictionary *ownedItems = [[NSMutableDictionary alloc] initWithDictionary:_items];
    
    NSArray* keys = [_items allKeys];
    for (NSString *key in keys) {
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[_items objectForKey:key]];
        for (int i = [items count] - 1; i >= 0; i--) {
            Item *item = [items objectAtIndex:i];
            if (item.amount == 0) {
                [items removeObject:item];
            }
        }
        [ownedItems setObject:items forKey:key];
    }
    
    return ownedItems;
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
