//
//  LAttegotchi.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "LAttegotchi.h"

#define ASCLAttegotchiName @"lattegotchiName"
#define ASCLAttegotchiHappiness @"lattegotchiHappiness"
#define ASCLAttegotchiHealth @"lattegotchiHealth"
#define ASCLAttegotchiBirthday @"lattegotchiBirthday"
#define ASCLAttegotchiWishes @"lattegotchiWishes"

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
    }
    return self;
}

@end
