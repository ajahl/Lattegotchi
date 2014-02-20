//
//  StrokeWish.h
//  LAttegotchi
//
//  Created by Codecamp on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Wish.h"

@interface StrokeWish : Wish {
    UIProgressView *_progressView;
}

@property (nonatomic, strong) UIProgressView *progressView;
@property unsigned int const strokeNumber;


@end
