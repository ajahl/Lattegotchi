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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSString *dataFile = [self getDataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataFile]) {
        NSLog(@"exists");
        NSData *playerData = [[NSFileManager defaultManager] contentsAtPath:dataFile];
        player = [NSKeyedUnarchiver unarchiveObjectWithData:playerData];
    } else {
        NSLog(@"not exists");
        player = [[Player alloc] init];
        player.name = @"thePlayer";
        player.money = 100;
        player.level = 0;
    }

    LAttegotchi* lattegotchi = [[LAttegotchi alloc] init];
    [[player lattegotchies] addObject: lattegotchi];
    lattegotchi.name = @"theLAttegotchi";
    lattegotchi.happiness = 50;
    lattegotchi.health = 50;
    
    Wish* wish1 = [[Wish alloc] init];
    [lattegotchi.wishes addObject:wish1];
    wish1.name = @"Wish 1";
    wish1.discription = @"Wish 1 Description";
    wish1.happiness = 5;
    wish1.health = 10;
    wish1.deadline = [NSDate dateWithTimeIntervalSinceNow: 60*60*5];
    
    Wish* wish2 = [[Wish alloc] init];
    [lattegotchi.wishes addObject:wish2];
    wish2.name = @"Wish 2";
    wish2.discription = @"Wish 2 Description";
    wish2.happiness = 15;
    wish2.health = 20;
    wish2.deadline = [NSDate dateWithTimeIntervalSinceNow: 60*60*3];
    
    Item* item1 = [[Item alloc] init];
    [wish2.items addObject:item1];
    item1.name = @"Item 1";
    item1.happiness = 0;
    item1.health = 5;
    item1.value = 35;
    
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSData *playerData = [NSKeyedArchiver archivedDataWithRootObject:player];
    [playerData writeToFile:[self getDataFilePath] atomically:YES];
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

@end
