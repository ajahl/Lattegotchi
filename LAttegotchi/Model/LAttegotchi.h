//
//  LAttegotchi.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAttegotchi : NSObject

@property long  happiness;
@property long  health;
@property NSString * name;
@property NSDate * birthday;

@property (nonatomic, retain) NSArray * wishes;

@end
