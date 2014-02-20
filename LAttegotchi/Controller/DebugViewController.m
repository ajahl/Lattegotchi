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

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
}
- (IBAction)buttonMath:(id)sender{
    
}
- (IBAction)buttonPush:(id)sender{
    
}
- (IBAction)buttonLetter:(id)sender{
    
}
- (IBAction)buttonShake:(id)sender{
    
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

@end
