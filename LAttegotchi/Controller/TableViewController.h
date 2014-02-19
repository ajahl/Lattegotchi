//
//  TableViewController.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wish.h"


@interface TableViewController : UITableViewController

@property NSMutableArray * data;

@property int currentTableView;

@property Wish *activeWish;

@end
