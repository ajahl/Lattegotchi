//
//  ViewController.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "ViewController.h"

#import "BackpackViewController.h"
#import "WishTableViewController.h"
#import "StoreTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (id)init
{
    self = [super init];
    if (self) {
        backpackController = [[BackpackViewController alloc] init];
        wishController = [[WishTableViewController alloc]init];
        storeController = [[StoreTableViewController alloc]init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menueSelector:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    switch (selectedSegment) {
        case 0:
            //Whish
        {
            UITableView *view =  [[UITableView alloc] init];
            
            [wishController setView:view];
            
            [_scrollView addSubview:view];

            break;
        }
        case 1:
            //Backpack
        {
            
        
            break;
        }
        case 2:
            //Store
            
        {
            
            
            break;
        }
        default:
            // bloed
            break;
    }
    
}

@end
