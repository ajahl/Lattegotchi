//
//  PushWish.h
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Wish.h"

@interface PushWish : Wish {
   IBOutlet UIButton *btn;
}


@property (nonatomic, retain) IBOutlet UILabel *lblSucceed;


@end
