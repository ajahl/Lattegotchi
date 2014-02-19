//
//  MysteryMathWish.m
//  LAttegotchi
//
//  Created by Codecamp on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "MysteryMathWish.h"

@implementation MysteryMathWish



-(void)execute {
    
    // Init GUI
    [self createAndInitUI];
    
}


- (void)createAndInitUI
{
    
    // create and add view
    UIView *subView = [self getSubView];
    
    // Add Text Button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, subView.frame.size.width, 50)];
    [lblDecription setText: self.description];
    [lblDecription setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDecription];
    
    // Add Text Button
    UILabel *lblDistanceTxt = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    [lblDistanceTxt setText: @"Distance: "];
    [lblDistanceTxt setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDistanceTxt];
    
//    // Create and add distance label
//    lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
//    [lblDistance setText: @"0.0 m"];
//    [lblDistance setTextColor: [UIColor orangeColor]];
//    [subView addSubview: lblDistance];
    
    // Add return button
    CGRect buttonFrame = CGRectMake( 10, subView.frame.size.height-30, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"Back" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button addTarget: self
               action: @selector(buttonClicked:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: button];
}

- (void) buttonClicked: (id)sender
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
