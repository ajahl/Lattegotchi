//
//  WishFactory.m
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "WishFactory.h"
#import "ItemWish.h"
#import "AppDelegate.h"
#import "Player.h"
#import "Item.h"

@implementation WishFactory


+ (ItemWish*) createItemWish{
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    ItemWish * wish = [[ItemWish alloc]init];
    
    Item * item = [[player items] objectAtIndex:0];
    
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
    
    
    
    return wish;
}
@end
