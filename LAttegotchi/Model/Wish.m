//
//  Wish.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Wish.h"
#import "Item.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"

#import <AudioToolbox/AudioToolbox.h>

#define ASCWishName @"wishName"
#define ASCWishDescription @"wishDescription"
#define ASCWishHappiness @"wishHappiness"
#define ASCWishHealth @"wishHealth"
#define ASCWishValue @"wishValue"
#define ASCWishStarttime @"wishStarttime"
#define ASCWishDeadline @"wishDeadline"
#define ASCWishItems @"wishItems"

@implementation Wish

- (id)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)initWithViewController:(UIViewController *) controller;
{
    _viewController = controller;
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    UIView *rootView = app.window.rootViewController.view;
    
        
    int hight =rootView.frame.size.height-292;
    CGRect bounds = CGRectMake(0, 292, rootView.frame.size.width, hight);
        
    _subView= [[UIView alloc] initWithFrame:bounds];
    [_subView setBackgroundColor: [UIColor whiteColor]];
    [rootView addSubview:_subView];
    
    // add animation
    _subView.frame = CGRectMake(0, 500, rootView.frame.size.width, hight);
    [UIView animateWithDuration:1.0
                     animations:^{
                         _subView.frame = bounds;
                     }];

}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCWishName];
    [aCoder encodeObject:self.discription forKey:ASCWishDescription];
    [aCoder encodeInt:self.happiness forKey:ASCWishHappiness];
    [aCoder encodeInt:self.health forKey:ASCWishHealth];
    [aCoder encodeInt:self.value forKey:ASCWishValue];
    [aCoder encodeObject:self.starttime forKey:ASCWishStarttime];
    [aCoder encodeObject:self.deadline forKey:ASCWishDeadline];
    [aCoder encodeObject:self.items forKey:ASCWishItems];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCWishName];
        _discription = [aDecoder decodeObjectForKey:ASCWishDescription];
        _happiness = [aDecoder decodeIntForKey:ASCWishHappiness];
        _health = [aDecoder decodeIntForKey:ASCWishHealth];
        _value = [aDecoder decodeIntForKey:ASCWishValue];
        _starttime = [aDecoder decodeObjectForKey:ASCWishStarttime];
        _deadline = [aDecoder decodeObjectForKey:ASCWishDeadline];
        _items = [aDecoder decodeObjectForKey:ASCWishItems];
    }
    return self;
}

-(NSString *)getName {
    return _name;
}

-(NSString *)getSubText {
    return [self getSubText:-1];
}

-(NSString *) getSubText:(int)usage {
    unichar heart = 0x2665;
    unichar smiley = 0x263A;
    unichar skull = 0x2620;
    
    NSString *subText = @"";
    
    if (_health == 0)
        subText = [subText stringByAppendingFormat:@"%C ±%d", heart, _health];
    else if (_health > 0)
        subText = [subText stringByAppendingFormat:@"%C +%d", heart, _health];
    else
        subText = [subText stringByAppendingFormat:@"%C %d", heart, _health];
    
    subText = [subText stringByAppendingString:@"\t"];
    
    if (_happiness == 0)
        subText = [subText stringByAppendingFormat:@"%C ±%d", smiley, _happiness];
    else if (_happiness > 0)
        subText = [subText stringByAppendingFormat:@"%C +%d", smiley, _happiness];
    else
        subText = [subText stringByAppendingFormat:@"%C %d", smiley, _happiness];
    
    subText = [subText stringByAppendingString:@"\t"];
    
    if (_value == 0)
        subText = [subText stringByAppendingFormat:@"%C ±%d", skull, _value];
    else if (_value > 0)
        subText = [subText stringByAppendingFormat:@"%C +%d", skull, _value];
    else
        subText = [subText stringByAppendingFormat:@"%C %d", skull, _value];
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *deadline = [dateFormat stringFromDate:_deadline];
//    subText = [subText stringByAppendingFormat:@"\t%@", deadline];
    
    NSTimeInterval interval = [_deadline timeIntervalSinceNow];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    subText = [subText stringByAppendingFormat:@"\t%@ left", formattedDate];
    
    return subText;
}

-(UIViewController *)getViewController {
    return _viewController;
}

-(UIView *)getSubView {
    return _subView;
}

-(void)execute {
    
}

- (void)success {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    Player *player = [app getPlayer];
    LAttegotchi *lattegotchi = [player.lattegotchies objectAtIndex:0];
    
    for (Item *item in _items) {
        [lattegotchi useItem:item];
    }
    
    lattegotchi.happiness = [self mapRange:lattegotchi.happiness + _happiness];
    lattegotchi.health = [self mapRange:lattegotchi.health + _health];
    player.money += _value;
    
    [lattegotchi.wishes removeObject:self];
    
    [app updateUI];
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}


- (void)deadlineReached {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    Player *player = [app getPlayer];
    LAttegotchi *lattegotchi = [player.lattegotchies objectAtIndex:0];
    
    lattegotchi.happiness = [self mapRange:lattegotchi.happiness - _happiness];
    lattegotchi.health = [self mapRange:lattegotchi.health - _health];
    
    [lattegotchi.wishes removeObject:self];
    
    [app updateUI];
}

- (BOOL) isAvailable {
    return YES;
}

- (int) mapRange:(int) val{
    if (val < 0) {
        return 0;
    }else if (val > 100){
        return 100;
    }else{
        return val;
    }
}

@end
