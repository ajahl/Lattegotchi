//
//  Item.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Item.h"

#define ASCItemName @"itemName"
#define ASCItemHappiness @"itemHappiness"
#define ASCItemHealth @"itemHealth"
#define ASCItemValue @"itemValue"

@implementation Item

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCItemName];;
    [aCoder encodeInt:self.happiness forKey:ASCItemHappiness];
    [aCoder encodeInt:self.health forKey:ASCItemHealth];
    [aCoder encodeInt:self.value forKey:ASCItemValue];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCItemName];
        _happiness = [aDecoder decodeIntForKey:ASCItemHappiness];
        _health = [aDecoder decodeIntForKey:ASCItemHealth];
        _value = [aDecoder decodeIntForKey:ASCItemValue];
    }
    return self;
}

-(NSString *)getName {
    return _name;
}

-(NSString *)getDiscription {
    return @"";
}


@end
