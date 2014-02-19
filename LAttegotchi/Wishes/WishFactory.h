//
//  WishFactory.h
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemWish;
@interface WishFactory : NSObject

+ (ItemWish*) createItemWish;

@end
