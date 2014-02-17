//
//  Wish.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wish : NSObject

@property NSString * name;
@property NSString * discription;
@property int happiness;
@property int health;
@property NSDate * deadline;

@property (nonatomic, retain) NSMutableArray * items;

@end
