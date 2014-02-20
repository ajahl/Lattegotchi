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
#import "HappyAnimation.h"
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
    
    UIImage *abc = [UIImage imageNamed: @"abc.png"];
    [dotView setABC:abc];
    NSString * aBCString = @"                                                0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[/]^_´abcdefghijklmnopqrstuvwxyz(|)";
    [dotView setABCString:aBCString];
    
    [self setAnimation];
}


-(void) setAnimation {
    if (_animation) {
        [_animation stopTimer];
        _animation = nil;
    }
        
    [_imageView addSubview:dotView];
    _animation = [[HappyAnimation alloc] init];
//    [_animation startTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUI {
    [tableViewController reload];
    [_tableView reloadData];
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
