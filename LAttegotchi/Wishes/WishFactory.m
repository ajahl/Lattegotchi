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
#import "MysteryMathWish.h"
#import "PushWish.h"
#import "AppDelegate.h"
#import "Player.h"
#import "ShakeWish.h"
#import "StrokeWish.h"
#import "Item.h"
#import "LAttegotchi.h"

#define LEVEL_FACTOR             10    /*  */
#define HEALTH_HAPPY_PER_PUSH     2    /*  */

#define MAXWISHHAPPINESS    10
#define MINWISHHAPPINESS     5
#define MAXWISHHEALTH       10
#define MINWISHHEALTH        5

@implementation WishFactory


+ (ItemWish*) createItemWish {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    ItemWish * wish = [[ItemWish alloc]init];
    Item * item = nil;
    do {
        NSArray* keys = [player.items allKeys];
        int random = arc4random_uniform([keys count]);
        NSArray* items = [player.items objectForKey:[keys objectAtIndex:random]];
        random = arc4random_uniform([items count]);
        item = [items objectAtIndex:random];
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
    
    int happiness = arc4random_uniform(MAXWISHHAPPINESS - MINWISHHAPPINESS);
    happiness += arc4random_uniform(MINWISHHAPPINESS);
    wish.happiness = item.happiness + happiness;
    
    int health = arc4random_uniform(MAXWISHHEALTH - MINWISHHEALTH);
    health += arc4random_uniform(MINWISHHEALTH);
    wish.health = item.health + health;
    
    float multiplier = arc4random_uniform(50) / 100.0f;
    int value = item.value * multiplier;
    if (value == 0) {
        value = 1;
    }
    wish.value = item.value + value;
    
    [wish.items addObject:item];
    
    return wish;
}

+ (GPSWish*) createGPSWish {
    
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    int level = lattegotchi.level;
    
    // create new wish and init with parameters
    GPSWish * wish = [[GPSWish alloc]init];
    
    wish.distance = arc4random_uniform(LEVEL_FACTOR * level);
    
    wish.name = @"Walking";
    wish.discription = [NSString stringWithFormat:@"Please go %im",  wish.distance];
    
    wish.happiness = LEVEL_FACTOR * level;
    wish.health = LEVEL_FACTOR * level;
    
    return wish;
}

+ (MysteryMathWish*) createMysteryMathWish {
    
    // get delegate and level information
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    int level = lattegotchi.level;
    
    // create new wish and init with parameters
    MysteryMathWish * wish = [[MysteryMathWish alloc]init];
    
    wish.num1 = arc4random_uniform(LEVEL_FACTOR * level);
    wish.num2 = arc4random_uniform(LEVEL_FACTOR * level);
    
    wish.name = @"Study Math";
    wish.discription = [NSString stringWithFormat:@"Add %i to %i: ",  wish.num1, wish.num2];
    
    wish.happiness = LEVEL_FACTOR * level;
    wish.health = LEVEL_FACTOR * level;
    
    return wish;
}

//
+ (PushWish*) createPushWish {
    
    // get delegate and level information
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    int level = lattegotchi.level;
    
    // create new wish and init with parameters
    PushWish * wish = [[PushWish alloc]init];
    wish.numOfpush = (arc4random_uniform(LEVEL_FACTOR * level) + 1);
    wish.name = @"Playing";
    wish.discription = [NSString stringWithFormat:@"Push %i times on the circules: ", wish.numOfpush];

    wish.happiness = wish.numOfpush * HEALTH_HAPPY_PER_PUSH;
    wish.health = wish.numOfpush * HEALTH_HAPPY_PER_PUSH;
    
    return wish;
}

//
+ (StrokeWish  *) createStrokeWish {
    
    // get delegate and level information
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    int level = lattegotchi.level;
    
    // create new wish and init with parameters
    StrokeWish * wish = [[StrokeWish alloc]init];
    wish.strokeNumber = (arc4random_uniform(LEVEL_FACTOR * level) + 1);
    wish.name = @"Stroke me!";
    wish.discription = [NSString stringWithFormat:@"Stroke %i times from left to right: ", wish.strokeNumber];
    wish.happiness = wish.strokeNumber * HEALTH_HAPPY_PER_PUSH;
    wish.health = wish.strokeNumber * HEALTH_HAPPY_PER_PUSH;
    
    return wish;
}

+ (ShakeWish*) createShakeWish {
    
    
    // get delegate and level information
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    int level = lattegotchi.level;
    
    // create new wish and init with parameters
    ShakeWish * wish = [[ShakeWish alloc]init];
    wish.shakeNumber = (arc4random_uniform(LEVEL_FACTOR * level) + 1);
    wish.name = [NSString stringWithFormat:@"Shake meee!"];
    wish.discription = [NSString stringWithFormat:@"Shake me %i times: ", wish.shakeNumber];
    wish.happiness = wish.shakeNumber * HEALTH_HAPPY_PER_PUSH;
    wish.health = wish.shakeNumber * HEALTH_HAPPY_PER_PUSH;
    
    return wish;
}

+ (Wish*) createWish {
    NSArray *allWishes = [NSArray arrayWithObjects:
                       [self createItemWish],
                       [self createGPSWish],
                       [self createMysteryMathWish],
                       [self createPushWish],
                       [self createStrokeWish],
                    nil];
    
    NSMutableArray *availableWishes = [[NSMutableArray alloc] init];
    for (Wish *wish in allWishes) {
        if ([wish isAvailable]) {
            [availableWishes addObject:wish];
        }
    }
    
    int index = arc4random_uniform([availableWishes count]);
    return [availableWishes objectAtIndex:index];
}

@end
