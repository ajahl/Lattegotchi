//
//  AppDelegate.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Player.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    Player* player;
}
//test

@property (strong, nonatomic) UIWindow *window;

- (Player*) getPlayer;
- (NSString*) getDataFilePath;
- (void) loadOrInitModel;

@end
