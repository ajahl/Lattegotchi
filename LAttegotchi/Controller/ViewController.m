//
//  ViewController.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "ViewController.h"

#import "Animation.h"
#import "TableViewController.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"
#import "DotImageView.h"
#import "HappyAnimationLevel1.h"
#import "HappyAnimationLevel2.h"
#import "HappyAnimationLevel3.h"
#import "HappyAnimationLevel4.h"
#import "HappyAnimationLevel5.h"
#import "Wish.h"


@implementation ViewController


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tv =  self.tableView;
    tableViewController = [[TableViewController alloc] init];
    [self addChildViewController:tableViewController];
    
    tv.dataSource = tableViewController;
    tv.delegate = tableViewController;
    tableViewController.view = tv;
    tableViewController.tableView = tv;
    
    dotView = [[DotImageView alloc] initWithFrame:[_imageView frame]];
    
    UIImage *image = [UIImage imageNamed: @"tamatama_normal1.png"];
    [dotView setImage:image ];
    
//    UIImage *emo = [UIImage imageNamed: @"happy_smile.png"];
//    [dotView setEmotion:emo];

    [dotView setEmotions: [NSArray arrayWithObjects:
                           @"unhappy_smile.png",@"neutral_smile.png",@"happy_smile.png",nil]];
    
    UIImage *heart = [UIImage imageNamed: @"heart.png"];
    [dotView setHeart:heart];
    
    UIImage *scull = [UIImage imageNamed: @"scull.png"];
    [dotView setScull:scull];

    UIImage *wishLamp = [UIImage imageNamed: @"wish_lamp.png"];
    [dotView setWishLamp:wishLamp];
    
    UIImage *sun = [UIImage imageNamed: @"sun.png"];
    [dotView setSun:sun];
    
    UIImage *cloud = [UIImage imageNamed: @"cloud2.png"];
    [dotView setCloud:cloud];
    
    UIImage *cloudsun = [UIImage imageNamed: @"cloudsun.png"];
    [dotView setCloudSun:cloudsun];
    
    UIImage *rain = [UIImage imageNamed: @"rain.png"];
    [dotView setRain:rain];
    
    UIImage *abc = [UIImage imageNamed: @"abc.png"];
    [dotView setABC:abc];
    NSString * aBCString = @"                                                0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[/]^_´abcdefghijklmnopqrstuvwxyz(|)";
    [dotView setABCString:aBCString];
    
    [self setAnimation];
}


-(void) setAnimation {
    if (_animation) {
//        [_animation stopTimer];
        _animation = nil;
    }
        
    [_imageView addSubview:dotView];
    _animation = [[HappyAnimationLevel1 alloc] init];
//    [_animation startTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(Player *) getPlayer {
    AppDelegate * app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    return [app getPlayer];
}

- (void) updateUI {
    [tableViewController reload];
    [_tableView reloadData];
    
    [self updateAnimation ];
}

int currentLevel = 1;
-(void) updateAnimation  {
    int level = [self getPlayer].level;
    
    if(currentLevel == level) {
        return;
    }
    
    currentLevel = level;
    
    switch (level) {
        case 1:
        {
            _animation = [[HappyAnimationLevel1 alloc] init];
        }
            break;
        case 2:
        {
            _animation = [[HappyAnimationLevel2 alloc] init];
        }
            break;
        case 3:
        {
            _animation = [[HappyAnimationLevel3 alloc] init];
        }
            break;
        case 4:
        {
            _animation = [[HappyAnimationLevel4 alloc] init];
        }
            break;
        case 5:
        {
            _animation = [[HappyAnimationLevel5 alloc] init];
        }
            break;
            
        default: {
            _animation = [[HappyAnimationLevel1 alloc] init];
        }
            break;
    }
    
    
}


-(LAttegotchi *) getLAtte {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    return latte;
}

- (IBAction)menueSelector:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    switch (selectedSegment) {
        case 0:
            //Wish
        {
            tableViewController.currentTableView = 0;
            break;
        }
        case 1:
            //Backpack
        {
            tableViewController.currentTableView = 1;
            break;
        }
        case 2:
            //Store
            
        {
            tableViewController.currentTableView = 2;
            break;
        }
        default:
            // bloed
            break;
    }
    [self updateUI];
}


//- (void) startTimer {
//    [NSTimer scheduledTimerWithTimeInterval:1
//                                     target:self
//                                   selector:@selector(tick:)
//                                   userInfo:nil
//                                    repeats:YES];
//}
//
//- (void) tick:(NSTimer *) timer {
//    
//        UIImage *image = [UIImage imageNamed:[image objectAtIndex:_animationIndex]];
//        
//        [dotView setImage:image ];
////        [dotView removeFromSuperview];
//    
//    _animationIndex++;
//    if ([_images count]-1 < _animationIndex) {
//        _animationIndex = 0;
//    }
//}


-(DotImageView *) getDotView {
    return dotView;
}

@end
