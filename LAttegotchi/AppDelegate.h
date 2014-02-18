//
//  AppDelegate.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Player.h"

#import "InitModelViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, InitModelAlertViewControllerDelegate> {
    Player* player;
}

@property (strong, nonatomic) UIWindow *window;

- (Player*) getPlayer;
- (NSString*) getDataFilePath;
- (void) saveModel;
- (void) loadModel;
- (void) initModel;

@end
