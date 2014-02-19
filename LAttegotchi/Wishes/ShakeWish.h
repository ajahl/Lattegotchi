//
//  ShakeWish.h
//  LAttegotchi
//
//  Created by Codecamp on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Wish.h"

@interface ShakeWish : Wish {
    IBOutlet UILabel *lblShakeProgress;
    IBOutlet UIProgressView * threadProgressView;

}

@end
