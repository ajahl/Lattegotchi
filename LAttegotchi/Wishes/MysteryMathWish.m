//
//  MysteryMathWish.m
//  LAttegotchi
//
//  Created by Codecamp on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "MysteryMathWish.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"

@implementation MysteryMathWish



-(void)execute {
    
    // Generate equation
    num1 = arc4random_uniform(50);
    num2 = arc4random_uniform(50);
    
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
    
    [lblDistanceTxt setText: [NSString stringWithFormat:@" %i + %i = ", num1, num2]];
    [lblDistanceTxt setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDistanceTxt];
    
    // Create and add distance label
    txtResult  = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [txtResult setTextColor: [UIColor orangeColor]];
    
    // Add
    [txtResult addTarget: self
               action: @selector(textFieldDidBeginEditing:)
     forControlEvents: UIControlEventEditingDidBegin];
    
    [txtResult addTarget: self
                  action: @selector(textFieldDidEndEditing:)
        forControlEvents: UIControlEventEditingDidEnd];
    [subView addSubview: txtResult];
    
    // Add return button
    CGRect buttonFrame = CGRectMake( 10, subView.frame.size.height-30, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"Back" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button addTarget: self
               action: @selector(buttonClicked:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: button];
    
    // Add eingabe button
    CGRect btnFrame = CGRectMake( subView.frame.size.width-100, subView.frame.size.height-30, 100, 30 );
    UIButton *btnInput = [[UIButton alloc] initWithFrame: btnFrame];
    [btnInput setTitle: @"Check" forState: UIControlStateNormal];
    [btnInput setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [btnInput addTarget: self
               action: @selector(buttonInputClicked:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: btnInput];
}

- (void) buttonClicked: (id)sender
{
    NSLog( @"Button clicked." );
    [[self getSubView] removeFromSuperview];
}

- (void) buttonInputClicked: (id)sender
{
    
    NSLog(@">>>>> %i", [txtResult.text intValue]);
    if ([txtResult.text intValue] == num1 + num2) {
        AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
        LAttegotchi *latte = [[app getPlayer].lattegotchies objectAtIndex:0];
        
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
        
        [latte.wishes removeObject:self];
        
        [app updateUI];
        
        [self closeWish];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Sorry :-("
                              message: nil
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        NSString *msg = [NSString stringWithFormat:@"Wrond. Try again!"];
        alert.message = msg;
        [alert show];
    }
    
    
    // Remove responder from text field
    [txtResult resignFirstResponder];
    
    // Start calulation
    
    NSLog( @"Button clicked." );
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [self getSubView].frame = CGRectMake(0,-10,320,400);
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [self getSubView].frame = CGRectMake(0, 292,320,400);
    [UIView commitAnimations];
}

- (void) closeWish
{
    
    NSLog( @"Close Wish" );
    [[self getSubView] removeFromSuperview];
}


@end
