//
//  LAttegotchi.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "LAttegotchi.h"
#import "Wish.h"
#import "Item.h"

#define ASCLAttegotchiName @"lattegotchiName"
#define ASCLAttegotchiHappiness @"lattegotchiHappiness"
#define ASCLAttegotchiHealth @"lattegotchiHealth"
#define ASCLAttegotchiBirthday @"lattegotchiBirthday"
#define ASCLAttegotchiWishes @"lattegotchiWishes"
#define ASCLAttegotchiWishesCompleted @"lattegotchiWishesCompleted"

@implementation LAttegotchi

- (id)init
{
    self = [super init];
    if (self) {
        _wishes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCLAttegotchiName];
    [aCoder encodeInt:self.happiness forKey:ASCLAttegotchiHappiness];
    [aCoder encodeInt:self.health forKey:ASCLAttegotchiHealth];
    [aCoder encodeObject:self.birthday forKey:ASCLAttegotchiBirthday];
    [aCoder encodeObject:self.wishes forKey:ASCLAttegotchiWishes];
    [aCoder encodeInt:self.wishesCompleted forKey:ASCLAttegotchiWishesCompleted];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCLAttegotchiName];
        _happiness = [aDecoder decodeIntForKey:ASCLAttegotchiHappiness];
        _health = [aDecoder decodeIntForKey:ASCLAttegotchiHealth];
        _birthday = [aDecoder decodeObjectForKey:ASCLAttegotchiBirthday];
        _wishes = [aDecoder decodeObjectForKey:ASCLAttegotchiWishes];
        _wishesCompleted = [aDecoder decodeIntForKey:ASCLAttegotchiWishesCompleted];
    }
    return self;
}

- (NSArray*) getActiveWishes {
    NSMutableArray *wishes = [[NSMutableArray alloc] init];
    for (Wish* wish in _wishes) {
        if ([wish.starttime compare:[NSDate date]] == NSOrderedAscending) {
            [wishes addObject:wish];
        }
    }
    return wishes;
}

- (BOOL) useItem:(Item*)item {
    if (item.amount > 0) {
        _happiness = [self mapRange:_happiness + item.happiness];
        _health = [self mapRange:_health + item.health];
        item.amount--;
        return YES;
    }
    return NO;
}

- (int) mapRange:(int) val{
    if (val < 0) {
        return 0;
    }else if (val > 100){
        return 100;
    }else{
        return val;
    }
}

@end
