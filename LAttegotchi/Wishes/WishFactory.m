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
    wish.happiness = item.happiness * 2;
    wish.health = item.health *2;
    wish.value = item.value*1.5;
    [wish.items addObject:item];
    
    return wish;
}

+ (GPSWish*) createGPSWish {
    GPSWish * wish = [[GPSWish alloc]init];
    [wish setDistance:25];
    
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

+ (PushWish*) createPushWish {
    PushWish * wish = [[PushWish alloc]init];
    
    [wish setName:@"WAAHHH ... I want a "];
    wish.happiness = 30;
    wish.health = 30;
    
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
    NSArray *allWishes = [NSArray arrayWithObjects:
                       [self createItemWish],
                       [self createGPSWish],
                       [self createMysteryMathWish],
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
