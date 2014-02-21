//
//  TableViewController.h
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeWish.h"


@interface TableViewController : UITableViewController {
    NSDictionary *data;
}

- (void) reload;

@property int currentTableView;

@property ShakeWish *shakeWish;


@end
