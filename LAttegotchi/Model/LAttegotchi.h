//
//  LAttegotchi.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface LAttegotchi : NSObject <NSCoding>

- (NSArray*) getActiveWishes;
- (BOOL) useItem:(Item*)item;

@property NSString * name;
@property int happiness;
@property int health;
@property NSDate * birthday;
@property int wishesCompleted;

@property (nonatomic, retain) NSMutableArray * wishes;

@end
