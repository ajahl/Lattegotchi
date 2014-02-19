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
#define ASCItemAmount @"itemAmount"

@implementation Item

- (id)init {
    self = [super init];
    if (self) {
        _amount = 0;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCItemName];;
    [aCoder encodeInt:self.happiness forKey:ASCItemHappiness];
    [aCoder encodeInt:self.health forKey:ASCItemHealth];
    [aCoder encodeInt:self.value forKey:ASCItemValue];
    [aCoder encodeInt:self.amount forKey:ASCItemAmount];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCItemName];
        _happiness = [aDecoder decodeIntForKey:ASCItemHappiness];
        _health = [aDecoder decodeIntForKey:ASCItemHealth];
        _value = [aDecoder decodeIntForKey:ASCItemValue];
        _amount = [aDecoder decodeIntForKey:ASCItemAmount];
    }
    return self;
}

-(NSString *)getName {
    return _name;
}

-(NSString *)getSubText {
    return [self getSubText:-1];
}

-(NSString *) getSubText:(int)usage {
    unichar heart = 0x2665;
    unichar smiley = 0x263A;
    unichar skull = 0x2620;
    unichar bag = 0xF4B0;
    
    NSString *subText = @"";
    subText = [subText stringByAppendingFormat:@"%C +%d", heart, _health];
    subText = [subText stringByAppendingFormat:@"\t%C +%d", smiley, _happiness];
    
    switch (usage) {
        case 1:
            subText = [subText stringByAppendingFormat:@"\t%C %d", bag, _amount];
            break;
        case 2:
            subText = [subText stringByAppendingFormat:@"\t%C %d", skull, _value];
            break;
    }
    
    return subText;
}


@end
