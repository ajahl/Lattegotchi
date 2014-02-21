//
//  Animation.h
//  LAttegotchi
//
//  Created by Alex Jahl on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
*   animation interface
*/
@interface Animation : NSObject {
    NSArray * sprites;
    NSTimer * timer;
}

@property NSArray * sprites;
@property int animationIndex;

- (void) startTimer;
-(void) stopTimer;

-(void) updateAnimation;

@end
