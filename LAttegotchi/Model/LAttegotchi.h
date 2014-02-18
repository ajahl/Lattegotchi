//
//  LAttegotchi.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAttegotchi : NSObject <NSCoding>

@property NSString * name;
@property int happiness;
@property int health;
@property NSDate * birthday;

@property (nonatomic, retain) NSMutableArray * wishes;

@end
