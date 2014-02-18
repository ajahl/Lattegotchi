//
//  AppDelegate.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "AppDelegate.h"
#import "LAttegotchi.h"
#import "Wish.h"
#import "Item.h"

#import "InitModelViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self loadModel];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveModel];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self loadModel];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (!player) {
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            // Put your code here
            [self initModel];
        });
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (Player *) getPlayer
{
    return player;
}

- (NSString*) getDataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data"];
}

- (void) saveModel {
    NSData *playerData = [NSKeyedArchiver archivedDataWithRootObject:player];
    [playerData writeToFile:[self getDataFilePath] atomically:YES];
}

- (void) loadModel {
    NSString *dataFile = [self getDataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataFile]) {
        NSLog(@"loaded");
        NSData *playerData = [[NSFileManager defaultManager] contentsAtPath:dataFile];
        player = [NSKeyedUnarchiver unarchiveObjectWithData:playerData];
    }
}

- (void) initModel {
    NSLog(@"init");
    InitModelAlertViewController *alertView = [[InitModelAlertViewController alloc] initWithDelegate:self];
    [_window.rootViewController presentViewController:alertView animated:YES completion:NULL];
}

- (void)finishedWithPlayername:(NSString *)playername withLAttegotchiName:(NSString *)lattegotchiname {
    player = [[Player alloc] init];
    player.name = playername;
    player.money = 100;
    player.level = 0;
    
    LAttegotchi* lattegotchi = [[LAttegotchi alloc] init];
    [[player lattegotchies] addObject: lattegotchi];
    lattegotchi.name = lattegotchiname;
    lattegotchi.happiness = 50;
    lattegotchi.health = 50;
    lattegotchi.birthday = [NSDate date];
    
//    Wish* wish1 = [[Wish alloc] init];
//    [lattegotchi.wishes addObject:wish1];
//    wish1.name = @"Wish 1";
//    wish1.discription = @"Wish 1 Description";
//    wish1.happiness = 5;
//    wish1.health = 10;
//    wish1.deadline = [NSDate dateWithTimeIntervalSinceNow: 60*60*5];
//    
//    Wish* wish2 = [[Wish alloc] init];
//    [lattegotchi.wishes addObject:wish2];
//    wish2.name = @"Wish 2";
//    wish2.discription = @"Wish 2 Description";
//    wish2.happiness = 15;
//    wish2.health = 20;
//    wish2.deadline = [NSDate dateWithTimeIntervalSinceNow: 60*60*3];
    
    Item* item1 = [[Item alloc] init];
    [player.items addObject:item1];
//    [wish2.items addObject:item1];
    item1.name = @"Item 1";
    item1.happiness = 0;
    item1.health = 5;
    item1.value = 35;
    
    Item* item2 = [[Item alloc] init];
    [player.items addObject:item2];
    item2.name = @"Item 2";
    item2.happiness = 20;
    item2.health = 10;
    item2.value = 50;
    
    [self saveModel];
}

@end
