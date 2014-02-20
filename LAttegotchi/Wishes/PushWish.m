//
//  PushWish.m
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "PushWish.h"
#import "AppDelegate.h"

int timeCounter = 0;
int clickCounter = 0;

@implementation PushWish
@synthesize lblSucceed;


-(void)execute {
    
    // Init timer
    [NSTimer scheduledTimerWithTimeInterval:1
                    target:self
                    selector:@selector(gameLoop:)
                    userInfo:nil
                    repeats:YES];
    
    // Init GUI
    [self createAndInitUI];
    
}

- (void) gameLoop:(NSTimer *) timer {
    
    if (timeCounter == 0) {
        [self createNewField];
    } else if (timeCounter == 2){
        [self removeField];
    } else if (timeCounter == 3){
        timeCounter = 0;
        return;
    }
    
    timeCounter++;
}


- (void)createAndInitUI
{
    
    // create and add view
    UIView *subView = [self getSubView];
    
    // Add Text Button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, subView.frame.size.width, 50)];
    [lblDecription setText: self.discription];
    [lblDecription setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDecription];
    
    // Add Text Button
    lblSucceed = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, subView.frame.size.width, 50)];
    [lblSucceed setText: [NSString stringWithFormat:@"%i", clickCounter]];
    [lblSucceed setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblSucceed];

    
    // Add return button
    CGRect buttonFrame = CGRectMake( 10, subView.frame.size.height-30, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"Back" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button addTarget: self
               action: @selector(clickedReturn:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: button];
}



- (void) createNewField {
    
    UIView *subView = [self getSubView];
    
    int x = (arc4random_uniform(subView.frame.size.width - 60) + 30);
    int y = (arc4random_uniform(subView.frame.size.height - 60) + 30);
    
    CGRect buttonFrame = CGRectMake( x, y, 30, 30 );
    btn = [[UIButton alloc] initWithFrame: buttonFrame];
    [btn setTitle: @"O" forState: UIControlStateNormal];
    [btn setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [btn addTarget: self
               action: @selector(clickedField:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: btn];
}

- (void) removeField {
    [btn removeFromSuperview];
}


- (void) clickedField: (id)sender
{
    clickCounter++;
    lblSucceed.text = [NSString stringWithFormat:@"%i", clickCounter];
    
    [self removeField];
    timeCounter = 0;
    
    if (clickCounter == 5) {
        AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
        
        NSString *name = [[app.getPlayer.lattegotchies objectAtIndex:0] name];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Congratulations :-)"
                              message: nil
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        NSString *msg = [NSString stringWithFormat:@"You fulfilled %@ wish. Thanks!", name];
        alert.message = msg;
        [alert show];
        
        [self success];
        [self closeWish];
    }
    
    NSLog( @"Button field clicked." );
}

- (void) clickedReturn: (id)sender
{
    NSLog( @"Button clicked." );
    [[self getSubView] removeFromSuperview];
}

- (void) closeWish
{
    
    NSLog( @"Close Wish" );
    [[self getSubView] removeFromSuperview];
}


@end
