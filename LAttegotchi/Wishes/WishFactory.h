//
//  WishFactory.h
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemWish, GPSWish, PushWish,MysteryLetterWish,MysteryMathWish, ShakeWish, Wish;
@interface WishFactory : NSObject

+ (ItemWish*) createItemWish;
+ (GPSWish*) createGPSWish;
+ (MysteryMathWish*) createMysteryMathWish;
+ (MysteryLetterWish*) createMysteryLetterWish;
+ (PushWish*) createPushWish;
+ (ShakeWish*) createShakeWish;
+ (Wish*) createWish;

@end
