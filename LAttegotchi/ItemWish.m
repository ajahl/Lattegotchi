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
    for (Item *item in self.items) {
        if ([item amount] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Needed Item not found"
                                                            message:@"you need to bye the needed item in your store"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    [self success];
}

@end
