//
//  NotificationFactory.m
//  LAttegotchi
//
//  Created by Alex Jahl on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "NotificationFactory.h"

#import "AppDelegate.h"
#import "Wish.h"
#import "LAttegotchi.h"
#import "Player.h"

@implementation NotificationFactory


+ (void) createNotifikation {
    LAttegotchi * latte = [self getLAttegotchi];
    
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
    
    //every 10 seconds
    int notifierCount = interval/ 10;
    for (int i = 1; i < notifierCount; i++ ){
        NSDate *sinceNow = [NSDate dateWithTimeIntervalSinceNow:interval/i];
        NSMutableString * text =  [[NSMutableString alloc]init];
        int next =(int)(interval -interval/i);
        NSString * string = nil;
        
        if (next > 0)
            string = [NSString stringWithFormat:@"dead in %is", next];
        
        //DEAD Notification
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



+ (void) createNotifikation:(NSDate*) date : (NSString * ) text{
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

+ (Player *) getPlayer {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    return [app getPlayer];
}

+ (LAttegotchi*) getLAttegotchi {
    
    return [[self getPlayer].lattegotchies objectAtIndex:0];
}

+ (NSDate * ) deadTime {
    NSDate * deadTime = nil;
    
    for (Wish* wish in [self getLAttegotchi ].wishes) {
        if ([wish.deadline compare:deadTime] == NSOrderedDescending || deadTime == nil) {
            deadTime = wish.deadline;
        }
    }
    
    return deadTime;
}

@end
