//
//  WishFactory.h
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemWish, GPSWish, PushWish, MysteryMathWish, ShakeWish, StrokeWish, Wish;
@interface WishFactory : NSObject

+ (ItemWish*) createItemWish;
+ (GPSWish*) createGPSWish;
+ (MysteryMathWish*) createMysteryMathWish;
+ (PushWish*) createPushWish;
+ (ShakeWish*) createShakeWish;
+ (StrokeWish*) createStrokeWish;
+ (Wish*) createWish;

@end
