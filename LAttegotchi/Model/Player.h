//
//  Player.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface Player : NSObject <NSCoding>

- (NSDictionary*) getOwnedItems;
- (BOOL) buyItem:(Item*)item;

@property NSString * name;
@property int money;

@property (nonatomic, retain) NSMutableArray * lattegotchies;
@property (nonatomic, retain) NSMutableDictionary * items;

@end
