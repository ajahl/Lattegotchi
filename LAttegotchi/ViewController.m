//
//  ViewController.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


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
    
//    switch (selectedSegment) {
//        case 0:
            //Whish
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            [button setTitle:@"Show View" forState:UIControlStateNormal];
            button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    
            [self.scrollView addSubview:button];
            
//            
//            break;
//        case 1:
//            //Backpack
//            
//            break;
//        
//        case 2:
//            //Store
//            
//            break;
//            
//        default:
//            // bloed
//            break;
//    }
    
}

@end
