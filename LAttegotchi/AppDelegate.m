//
//  AppDelegate.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Player.h"
#import "LAttegotchi.h"
#import "Wish.h"
#import "GPSWish.h"
#import "MysteryMathWish.h"
#import "MysteryLetterWish.h"
#import "Item.h"

#define MAXWISHTIME         10//60*5     /* SECONDS */
#define MINWISHTIME         5//60*1     /* SECONDS */
#define MAXWISHHAPPINESS    10
#define MINWISHHAPPINESS     5
#define MAXWISHHEALTH       10
#define MINWISHHEALTH        5
#define MAXWISHDEADLINE     60*15    /* SECONDS */
#define MINWISHDEADLINE     60*5     /* SECONDS */

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
    [self createNotifikation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self loadModel];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
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
    } else {
        [self startGame];
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
        NSData *playerData = [[NSFileManager defaultManager] contentsAtPath:dataFile];
        player = [NSKeyedUnarchiver unarchiveObjectWithData:playerData];
    }
}

- (void) initModel {
    InitModelAlertViewController *alertView = [[InitModelAlertViewController alloc] initWithDelegate:self];
    [_window.rootViewController presentViewController:alertView animated:YES completion:NULL];
}

- (void) startGame {
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    wishesMemory = [lattegotchi getActiveWishes];
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(wishTick:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) updateUI {
    ViewController* viewController = (ViewController*) _window.rootViewController;
    [viewController.tableView reloadData];
}

- (BOOL) generateNewWish:(LAttegotchi*) lattegotchi; {
    // TODO: check for happiness to die
    BOOL lattegotchiWouldDie = NO;
    
    int maxHappinessLost = 0;
    int maxHealthLost = 0;
    NSDate *latestBegin = [NSDate date];
    for (Wish* wish in lattegotchi.wishes) {
        maxHappinessLost += wish.happiness;
        maxHealthLost += wish.health;
        if ([wish.starttime compare:latestBegin] == NSOrderedDescending) {
            latestBegin = wish.starttime;
        }
    }
    if (maxHappinessLost >= lattegotchi.happiness
            || maxHealthLost >= lattegotchi.health) {
        lattegotchiWouldDie = YES;
    }
    
    if (!lattegotchiWouldDie) {
        MysteryMathWish* wish = [[MysteryMathWish alloc] init];
        wish.name = @"Wish";
        wish.discription = @"Wish Description";
        wish.happiness = rand() % (MAXWISHHAPPINESS - MINWISHHAPPINESS) + MINWISHHAPPINESS;
        wish.health = rand() % (MAXWISHHEALTH - MINWISHHEALTH) + MINWISHHEALTH;
        
        int starttime = rand() % (MAXWISHTIME - MINWISHTIME) + MINWISHTIME;
        wish.starttime = [latestBegin dateByAddingTimeInterval:starttime];
        int deadline = rand() % (MAXWISHDEADLINE - MINWISHDEADLINE) + MINWISHDEADLINE;
        wish.deadline = [wish.starttime dateByAddingTimeInterval:deadline];
        [lattegotchi.wishes addObject:wish];
        return YES;
    }
    return NO;
}

- (NSArray*) getNewActiveWishes {
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    NSArray* activeWishes = [lattegotchi getActiveWishes];
    NSMutableArray* newActiveWishes = [[NSMutableArray alloc] init];
    for (Wish *wish in activeWishes) {
        if (![wishesMemory containsObject:wish]) {
            [newActiveWishes addObject:wish];
        }
    }
    wishesMemory = activeWishes;
    return newActiveWishes;
}

- (void) wishTick:(NSTimer *) timer {
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    while ([self generateNewWish:lattegotchi]) {
        // generateWishes until death
    }
    NSArray* newActiveWishes = [self getNewActiveWishes];
    for (Wish *wish in newActiveWishes) {
        NSLog(@"newActiveWish: %@", wish.name);
    }
    [self updateUI];
}

- (void) finishedWithPlayername:(NSString *)playername withLAttegotchiName:(NSString *)lattegotchiname {
    player = [[Player alloc] init];
    player.name = playername;
    player.money = 100;
    player.level = 20;
    
    LAttegotchi* lattegotchi = [[LAttegotchi alloc] init];
    [player.lattegotchies addObject: lattegotchi];
    lattegotchi.name = lattegotchiname;
    lattegotchi.happiness = 80;
    lattegotchi.health = 5;
    lattegotchi.birthday = [NSDate date];
    
    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    for (NSDictionary *itemDict in [dict objectForKey:@"items"]) {
        Item* item = [[Item alloc] init];
        item.name = [itemDict objectForKey:@"name"];
        item.happiness = [[itemDict objectForKey:@"happiness"] intValue];
        item.health = [[itemDict objectForKey:@"health"] intValue];
        item.value = [[itemDict objectForKey:@"value"] intValue];
        [player.items addObject:item];
    }
    
    [self generateNewWish:lattegotchi];
    [self updateUI];
    [self saveModel];
    [self startGame];
}

- (void) createNotifikation {
    LAttegotchi * latte = [player.lattegotchies objectAtIndex:0];
    
    for (Wish * wish in latte.wishes) {
        
        NSMutableString * text =  [[NSMutableString alloc]init];
        [text appendString:[wish name]];
        [text appendString:@"Your LAttegotchi needs you, or will die"];
        
        [self createNotifikation:wish.starttime:text];
    }
}

- (void) createNotifikation:(NSDate*) date : (NSString * ) text{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = date;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	// Notification details
    localNotif.alertBody = text;
	// Set the action button
    localNotif.alertAction = @"View";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}



@end
