//
//  AppDelegate.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InitModelViewController.h"

@class Player;
@class LAttegotchi;

@interface AppDelegate : UIResponder <UIApplicationDelegate, InitModelAlertViewControllerDelegate> {
    Player* player;
}
//test

@property (strong, nonatomic) UIWindow *window;

- (Player*) getPlayer;
- (NSString*) getDataFilePath;
- (void) saveModel;
- (void) loadModel;
- (void) initModel;
- (void) startGame;
- (void) updateUI;
- (BOOL) generateNewWish:(LAttegotchi*) lattegotchi;
- (void) wishTick:(NSTimer *) timer;

@end
