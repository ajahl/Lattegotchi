//
//  ItemWish.m
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "ItemWish.h"
#import "Item.h"
#import "Player.h"
#import "LAttegotchi.h"
#import "AppDelegate.h"


@implementation ItemWish

-(void)execute {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    
    for (Item * item in [player items]) {
        if (item == [[self items] objectAtIndex:0]) {
            if ([item amount] > 0) {
                item.amount--;
                latte.happiness = [self mapRange:item.happiness + latte.happiness ];
                latte.health = [self mapRange:item.health + latte.health ];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Needed Item not found"
                                                                message:@"you need to bye the needed item in your store"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}
- (int) mapRange:(int) val{
    if (val < 0) {
        return 0;
    }else if (val > 100){
        return 100;
    }else{
        return val;
    }
}


@end
