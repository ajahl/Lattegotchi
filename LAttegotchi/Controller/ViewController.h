//
//  ViewController.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewController, LAttegotchi, DotImageView;


@interface ViewController : UIViewController {
    TableViewController  * tableViewController;
    DotImageView * dotView;
    bool toggle;
}

@property IBOutlet UIScrollView * scrollView;
@property IBOutlet UITableView * tableView;
@property IBOutlet UIImageView * imageView;
@property NSArray * images ;
@property int animationIndex;



-(LAttegotchi *) getLAtte;

- (IBAction)menueSelector:(id)sender;
-(IBAction)button:(id)sender;


@end
