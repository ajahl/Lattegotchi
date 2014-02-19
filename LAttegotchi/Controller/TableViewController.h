//
//  TableViewController.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wish.h"
#import "GPSWish.h"


@interface TableViewController : UITableViewController {
    NSArray *data;
}

@property int currentTableView;

@property GPSWish *activeWish;

@end
