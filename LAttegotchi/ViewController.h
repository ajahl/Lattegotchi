//
//  ViewController.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WishTableViewController ;
@class BackpackViewController;
@class StoreTableViewController;


@interface ViewController : UIViewController{
    WishTableViewController * wishController;
    BackpackViewController * backpackController;
    StoreTableViewController * storeController;
    
}

@property IBOutlet UIScrollView * scrollView;

- (IBAction)menueSelector:(id)sender;


@end
