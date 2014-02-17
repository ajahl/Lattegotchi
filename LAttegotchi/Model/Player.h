//
//  Player.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject <NSCoding>

@property NSString * name;
@property int money;
@property int level;

@property (nonatomic, retain) NSMutableArray * lattegotchies;
@property (nonatomic, retain) NSMutableArray * items;

@end
