//
//  WishFactory.m
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "WishFactory.h"
#import "Wish.h"
#import "ItemWish.h"
#import "GPSWish.h"
#import "MysteryLetterWish.h"
#import "MysteryMathWish.h"
#import "PushWish.h"
#import "AppDelegate.h"
#import "Player.h"
#import "ShakeWish.h"
#import "Item.h"

#define PUSH_PER_WISH             10   /* REAL PUSH = PUSH_PER_WISH * RANDOM NUMBER */
#define HEALTH_HAPPY_PER_PUSH     2    /*  */

@implementation WishFactory


+ (ItemWish*) createItemWish{
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    ItemWish * wish = [[ItemWish alloc]init];
    Item * item = nil;
    do {
        int random = arc4random_uniform([[player items] count]);
        item =[[player items] objectAtIndex:random];
    } while ([item value] > player.money && player.money > 50 );
   
    
    NSMutableString *description = [[NSMutableString alloc]init];
    
    [description appendString:@"you have to use "];
    [description appendString:[item name]];
    [description appendString:@"!"];
    [wish setDiscription:description];
    
    NSMutableString *name = [[NSMutableString alloc]init];
    [name appendString:@"WAAHHH ... I want a "];
    [name appendString:item.name];
    [wish setName:name];
    wish.happiness = item.happiness * 2;
    wish.health = item.health *2;
    wish.value = item.value*1.5;
    [wish.items addObject:item];
    
    return wish;
}

+ (GPSWish*) createGPSWish {
    GPSWish * wish = [[GPSWish alloc]init];
    wish.distance = 25;
    
    [wish setName:@"WAAHHH ... I want a "];
    wish.happiness = 30;
    wish.health = 30;
    
    return wish;
}

+ (MysteryMathWish*) createMysteryMathWish {
    MysteryMathWish * wish = [[MysteryMathWish alloc]init];
    
    [wish setName:@"WAAHHH ... I want a "];
    wish.happiness = 30;
    wish.health = 30;
    
    return wish;
}

+ (MysteryLetterWish*) createMysteryLetterWish {
    MysteryLetterWish * wish = [[MysteryLetterWish alloc]init];
    
    [wish setName:@"WAAHHH ... I want a "];
    wish.happiness = 30;
    wish.health = 30;
    
    return wish;
}

//
+ (PushWish*) createPushWish {
    
    // get delegate and level information
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    int level = [app getPlayer].level;
    
    // create new wish and init with parameters
    PushWish * wish = [[PushWish alloc]init];
    wish.numOfpush = (arc4random_uniform(PUSH_PER_WISH*level) + 1);
    wish.name = [NSString stringWithFormat:@"Push %i times", wish.numOfpush];
    wish.discription = [NSString stringWithFormat:@"Push %i times on the circules: ", wish.numOfpush];

    wish.happiness = wish.numOfpush * HEALTH_HAPPY_PER_PUSH;
    wish.health = wish.numOfpush * HEALTH_HAPPY_PER_PUSH;
    
    return wish;
}

+ (ShakeWish*) createShakeWish {
    ShakeWish * wish = [[ShakeWish alloc]init];
    
    [wish setName:@"WAAHHH ... I want a "];
    wish.happiness = 30;
    wish.health = 30;
    
    return wish;
}

+ (Wish*) createWish {
    NSArray *wishes = [NSArray arrayWithObjects:
                       [self createItemWish],
                       [self createGPSWish],
                       [self createMysteryMathWish],
                       [self createPushWish],
                    nil];
    
    int random = arc4random_uniform([wishes count]);
    return [wishes objectAtIndex:random];
}

@end
