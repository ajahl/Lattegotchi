//
//  DebugViewController.m
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "DebugViewController.h"
#import "WishFactory.h"
#import "Wish.h"
#import "ItemWish.h"
#import "GPSWish.h"
#import "MysteryLetterWish.h"
#import "MysteryMathWish.h"
#import "PushWish.h"
#import "AppDelegate.h"
#import "Player.h"
#import "ShakeWish.h"
#import "Item.h"
#import "ViewController.h"
#import "LAttegotchi.h"
#import "Weather.h"

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [_switchWeather setOn:[Weather isUpdating]];
        [_buttonWeatherSkyisclear setEnabled:![Weather isUpdating]];
        [_buttonWeatherFewCloud setEnabled:![Weather isUpdating]];
        [_buttonWeatherCloud setEnabled:![Weather isUpdating]];
        [_buttonWeatherRain setEnabled:![Weather isUpdating]];
        [_buttonWeatherUnknown setEnabled:![Weather isUpdating]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    [_levelstepper setValue:player.level];
    [ _levelLabel setText: [NSString stringWithFormat:@"%d" ,player.level ]];
    
    [_debugsw setOn:app.debugMode];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonItem:(id)sender{
    Wish * wish =  [WishFactory createItemWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonGPS:(id)sender{
    Wish * wish =  [WishFactory createGPSWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonMath:(id)sender{
    Wish * wish =  [WishFactory createMysteryMathWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonPush:(id)sender{
    Wish * wish =  [WishFactory createPushWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonLetter:(id)sender{
    Wish * wish =  [WishFactory createMysteryLetterWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonStroke:(id)sender{
    Wish * wish =  (Wish*)[WishFactory createStrokeWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonShake:(id)sender{
    Wish * wish =  [WishFactory createShakeWish];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    wish.starttime = [NSDate dateWithTimeIntervalSinceNow:0];
    wish.deadline = [wish.starttime dateByAddingTimeInterval:40];
    [[latte wishes] addObject:wish];
}
- (IBAction)buttonBack:(id)sender{
     [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)buttonMoney:(id)sender{
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    player.money += 100;
}
- (IBAction)buttonHappyHealth:(id)sender{
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    
    latte.happiness = 100;
    latte.health = 100;
}
- (IBAction)switchDebugMode:(id)sender{
    UISwitch * sw = (UISwitch*) sender;
    
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    app.debugMode = [sw isOn];
    
    Player *player = [app getPlayer];
    LAttegotchi *latte = [player.lattegotchies objectAtIndex:0];
    
    [latte.wishes removeAllObjects];
    
    ViewController* viewController = (ViewController*) [app window].rootViewController;
    [viewController.tableView reloadData];
    
}
- (IBAction)stepperLevel:(id)sender{
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player *player = [app getPlayer];
    player.level = (int)_levelstepper.value;
    [ _levelLabel setText: [NSString stringWithFormat:@"%d" ,player.level ]];
}

- (IBAction)switchWeather:(id)sender {
    UISwitch * sw = (UISwitch*) sender;
    if ([sw isOn]) {
        [Weather startUpdate];
    } else {
        [Weather stopUpdate];
    }
    
    [_buttonWeatherSkyisclear setEnabled:![Weather isUpdating]];
    [_buttonWeatherFewCloud setEnabled:![Weather isUpdating]];
    [_buttonWeatherCloud setEnabled:![Weather isUpdating]];
    [_buttonWeatherRain setEnabled:![Weather isUpdating]];
    [_buttonWeatherUnknown setEnabled:![Weather isUpdating]];
}

- (IBAction)buttonWeatherSkyisclear:(id)sender {
    [Weather setWeather:SKYISCLEAR];
}

- (IBAction)buttonWeatherFewCloud:(id)sender {
    [Weather setWeather:FEWCLOUDS];
}

- (IBAction)buttonWeatherCloud:(id)sender {
    [Weather setWeather:SCATTEREDCLOUDS];
}

- (IBAction)buttonWeatherRain:(id)sender {
    [Weather setWeather:RAIN];
}

- (IBAction)buttonWeatherUnknown:(id)sender {
    [Weather setWeather:UNKNOWN];
}

@end
