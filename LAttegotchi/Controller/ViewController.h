//
//  ViewController.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewController;


@interface ViewController : UIViewController{
    TableViewController  * tableViewController;
}

@property IBOutlet UIScrollView * scrollView;
@property IBOutlet UITableView * tableView;

- (IBAction)menueSelector:(id)sender;


@end
