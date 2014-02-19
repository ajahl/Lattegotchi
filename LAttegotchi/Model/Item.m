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
    NSString *subText = @"";//[@"" UTF8String];
    subText = [subText stringByAppendingFormat:@"ha: %d", _happiness];
    
    return subText;
}


@end
