//
//  Animation.m
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Animation.h"

#import "AppDelegate.h"
#import "ViewController.h"
#import "DotImageView.h"

@implementation Animation

@synthesize sprites;

- (id)init
{
    self = [super init];
    if (self) {
        sprites = [NSArray arrayWithObjects:
                   @"tamatama_nomal1.png", nil];
    }
    return self;
}

- (void) startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(tick:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) stopTimer {
    [timer invalidate];
    timer = nil;
}

- (void) tick:(NSTimer *) timer {
    [self updateAnimation];
}

-(void) updateAnimation {
    UIImage *image = [UIImage imageNamed:[sprites objectAtIndex:_animationIndex]];
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    ViewController * controller = (ViewController *) app.window.rootViewController;
    
    [[controller getDotView] setImage:image];
    _animationIndex++;
    if ([sprites count]-1 < _animationIndex) {
        _animationIndex = 0;
    }
}

@end
