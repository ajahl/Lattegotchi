//
//  ViewController.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "ViewController.h"

#import "TableViewController.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"
#import "DotImageView.h"





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
    
    tableViewController.data = [[self getLAtte] wishes];
    [(UITableView*)[tableViewController view] reloadData];
    
    dotView = [[DotImageView alloc] initWithFrame:[_imageView frame]];
    [_imageView addSubview:dotView];
    
    UIImage *image = [UIImage imageNamed: @"tamatama_normal1.png"];

    [dotView setImage:image ];
    
     _images = [NSArray arrayWithObjects:  @"tamatama_nomal1.png",@"tamatama_nomal2.png",@"tamatama_nomal3.png",@"tamatama_nomal4.png",  nil];
    
    [self startTimer];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(LAttegotchi *) getLAtte {
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    return latte;
}

- (IBAction)menueSelector:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [self getLAtte];
    switch (selectedSegment) {
        case 0:
            //Whish
        {
            
            tableViewController.data = [latte wishes];

            break;
        }
        case 1:
            //Backpack
        {
            
            tableViewController.data = [[app getPlayer] items];
            break;
        }
        case 2:
            //Store
            
        {
             tableViewController.data = [[app getPlayer] items];
            
            break;
        }
        default:
            // bloed
            break;
    }
    
    UITableView * t = (UITableView*)[tableViewController view];
    [t reloadData];
    
}


- (void) startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(tick:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) tick:(NSTimer *) timer {
    
        UIImage *image = [UIImage imageNamed:[_images objectAtIndex:_animationIndex]];
        
        [_imageView setImage:image ];
    
    
    _animationIndex++;
    if ([_images count]-1 < _animationIndex) {
        _animationIndex = 0;
    }
}

@end
