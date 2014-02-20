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
#import "WishFactory.h"
#import "Animation.h"

#define MAXWISHTIME         10//60*5     /* SECONDS */
#define MINWISHTIME         5//60*1     /* SECONDS */
#define MAXWISHHAPPINESS    10
#define MINWISHHAPPINESS     5
#define MAXWISHHEALTH       10
#define MINWISHHEALTH        5
#define MAXWISHDEADLINE     30//60*15    /* SECONDS */
#define MINWISHDEADLINE     15//60*5     /* SECONDS */

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
    ViewController* viewController =  (ViewController*) _window.rootViewController;
    [viewController.animation startTimer];
    
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    wishesMemory = [lattegotchi getActiveWishes];
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(gameLoop:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) updateUI {
    ViewController* viewController = (ViewController*) _window.rootViewController;
    [viewController updateUI];
    [viewController.tableView reloadData];
}

- (BOOL) generateNewWishFor:(LAttegotchi*) lattegotchi; {
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
        Wish* wish = [WishFactory createWish];
        
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

- (void) gameLoop:(NSTimer *) timer {
    LAttegotchi* lattegotchi = [player.lattegotchies objectAtIndex:0];
    while ([self generateNewWishFor:lattegotchi]) {
        // generateWishes until death
    }
    
    // Check for new active Wishes
    NSArray* newActiveWishes = [self getNewActiveWishes];
    for (Wish *wish in newActiveWishes) {
        //NSLog(@"newActiveWish: %@", wish.name);
    }
    
    // Check for deadline
    NSArray* wishes = [lattegotchi.wishes copy];
    for (Wish *wish in wishes) {
        if ([wish.deadline compare:[NSDate date]] == NSOrderedAscending) {
            [wish failed];
        }
    }
    
    // Check if lost
    if (lattegotchi.happiness <= 0 || lattegotchi.health <= 0) {
        [timer invalidate];
        
        NSString *message = [NSString stringWithFormat:@"%@ is ", lattegotchi.name];
        if (lattegotchi.happiness <= 0) {
            message = [message stringByAppendingString:@"too sad"];
        }
        if (lattegotchi.happiness <= 0 && lattegotchi.health <= 0) {
            message = [message stringByAppendingString:@"and "];
        }
        if (lattegotchi.health <= 0) {
            message = [message stringByAppendingString:@"dead"];
        }
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lattegotchi.birthday];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSString *formattedDate = [dateFormatter stringFromDate:date];
        message = [message stringByAppendingFormat:@"!\nHe was alive for %@.", formattedDate];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"You lost!"
                              message: message
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        [alert show];
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
    lattegotchi.happiness = 50;
    lattegotchi.health = 50;
    lattegotchi.birthday = [NSDate date];
    
    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    NSDictionary* itemsDict = [dict objectForKey:@"items"];
    NSArray* keys = [itemsDict allKeys];
    for (NSString* key in keys) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (NSDictionary *itemDict in [itemsDict objectForKey:key]) {
            
            
            Item* item = [[Item alloc] init];
            item.name = [itemDict objectForKey:@"name"];
            item.happiness = [[itemDict objectForKey:@"happiness"] intValue];
            item.health = [[itemDict objectForKey:@"health"] intValue];
            item.value = [[itemDict objectForKey:@"value"] intValue];
            
            [items addObject:item];
        }
        
        [player.items setObject:items forKey:key];
    }
    
    [self generateNewWishFor:lattegotchi];
    [self updateUI];
    [self saveModel];
    [self startGame];
}

- (void) createNotifikation {
    LAttegotchi * latte = [player.lattegotchies objectAtIndex:0];
    
    for (Wish * wish in latte.wishes) {
        
        if ([wish.starttime compare:[NSDate date]] == NSOrderedAscending) {
            continue;
        }
        
        NSMutableString * text =  [[NSMutableString alloc]init];
        [text appendString:[wish name]];
        [text appendString:@"Your LAttegotchi needs you, or will die"];
        
        [self createNotifikation:wish.starttime:text];
    }
    
    
    // dead notifier
    NSDate * deadTime = [self deadTime];
    if (!deadTime)
        return;
    
    NSDate * now = [NSDate date];
    
    NSTimeInterval interval = [deadTime timeIntervalSinceDate:now];
    
    for (int i = 1; i < 5; i++ ){
        NSDate *sinceNow = [NSDate dateWithTimeIntervalSinceNow:interval/i];
        NSMutableString * text =  [[NSMutableString alloc]init];
        int next =(int)(interval -interval/i);
        NSString * string = nil;
        if (next > 0)
             string = [NSString stringWithFormat:@"dead in %is", next];
        else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd - HH:mm:ss";
            
            NSDate * birthday = [self getLAttegotchi].birthday;
            NSTimeInterval lifeTime = [deadTime timeIntervalSinceDate:birthday];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:lifeTime];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            NSString *formattedDate = [dateFormatter stringFromDate:date];
            
             string = [NSString stringWithFormat:@"is DEAD after %@", formattedDate ];
        }
        [text appendString:string];
        
        [self createNotifikation:sinceNow :text];
    }
}

-(NSDate * ) deadTime {
    NSDate * deadTime = nil;
    
    for (Wish* wish in [self getLAttegotchi ].wishes) {
        if ([wish.deadline compare:deadTime] == NSOrderedDescending || deadTime == nil) {
            deadTime = wish.deadline;
        }
    }
    
    return deadTime;
}

- (LAttegotchi*) getLAttegotchi {
    return [player.lattegotchies objectAtIndex:0];
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ViewController* viewController =  (ViewController*) _window.rootViewController;
    [viewController.animation stopTimer];
    player = nil;
    [self initModel];
}

@end
