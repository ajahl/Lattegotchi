//
//  Player.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property NSString * name;
@property long money;
@property long level;

@property (nonatomic, retain) NSArray * lattegotchies;
@property (nonatomic, retain) NSArray * items;

@end
