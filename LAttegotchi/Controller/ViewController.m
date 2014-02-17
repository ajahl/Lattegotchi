//
//  ViewController.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "ViewController.h"

#import "TableViewController.h"

@interface ViewController ()

@end

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
            UITableView *tv =  self.tableView;
            TableViewController  * controller = [[TableViewController alloc] init];
            
            tv.dataSource = controller;
            tv.delegate = controller;
            controller.view = tv;
            controller.tableView = tv;

////            [wishController setView:view];
//
//            [_scrollView addSubview:view];
//            
//            [super viewWillAppear:YES];
//            [view reloadData];

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
