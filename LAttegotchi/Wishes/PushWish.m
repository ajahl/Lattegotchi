//
//  PushWish.m
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "PushWish.h"

@implementation PushWish

-(void)execute {
    
    // Init timer
    [NSTimer scheduledTimerWithTimeInterval:2
                    target:self
                    selector:@selector(gameLoop:)
                    userInfo:nil
                    repeats:YES];
    
    // Init GUI
    [self createAndInitUI];
    
}

- (void) gameLoop:(NSTimer *) timer {
    
    
    
//    x = arc4random_uniform();
//    y  = arc4random_uniform(50);
//    
//    
//    
//    CGRect frame = CGRectMake( x, subView.frame.size.height-30, 20, 20 );
//    
//    self.circleView = [[UIView alloc] initWithFrame:CGRectMake(10,20,100,100)];
//    circleView.alpha = 0.5;
//    self.circleView.layer.cornerRadius = 50;
//    self.circleView.backgroundColor = [UIColor blueColor];
    
    
    NSLog(@"Timer Call");
}


- (void)createAndInitUI
{
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
//    [tapRecognizer setNumberOfTapsRequired:1];
//    [tapRecognizer setDelegate:self];
//    [self.view addGestureRecognizer:tapRecognizer];
    
    
    // create and add view
    UIView *subView = [self getSubView];
    
    // Add Text Button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, subView.frame.size.width, 50)];
    [lblDecription setText: self.description];
    [lblDecription setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDecription];
    
//    // Add Text Button
//    UILabel *lblDistanceTxt = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
//    
//    [lblDistanceTxt setText: [NSString stringWithFormat:@" %i + %i = ", num1, num2]];
//    [lblDistanceTxt setTextColor: [UIColor orangeColor]];
//    [subView addSubview: lblDistanceTxt];
//    
//    // Create and add distance label
//    txtResult  = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
//    [txtResult setTextColor: [UIColor orangeColor]];
//    
//    // Add
//    [txtResult addTarget: self
//                  action: @selector(textFieldDidBeginEditing:)
//        forControlEvents: UIControlEventEditingDidBegin];
//    
//    [txtResult addTarget: self
//                  action: @selector(textFieldDidEndEditing:)
//        forControlEvents: UIControlEventEditingDidEnd];
//    [subView addSubview: txtResult];
    
    // Add return button
    CGRect buttonFrame = CGRectMake( 10, subView.frame.size.height-30, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"Back" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button addTarget: self
               action: @selector(buttonClicked:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: button];
    
//    // Add eingabe button
//    CGRect btnFrame = CGRectMake( subView.frame.size.width-100, subView.frame.size.height-30, 100, 30 );
//    UIButton *btnInput = [[UIButton alloc] initWithFrame: btnFrame];
//    [btnInput setTitle: @"Check" forState: UIControlStateNormal];
//    [btnInput setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
//    [btnInput addTarget: self
//                 action: @selector(buttonInputClicked:)
//       forControlEvents: UIControlEventTouchDown];
//    [subView addSubview: btnInput];
}

- (void) buttonClicked: (id)sender
{
    NSLog( @"Button clicked." );
    [[self getSubView] removeFromSuperview];
}

//- (void) buttonInputClicked: (id)sender
//{
//    
//    NSLog(@">>>>> %i", [txtResult.text intValue]);
//    if ([txtResult.text intValue] == num1 + num2) {
//        AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
//        LAttegotchi *latte = [[app getPlayer].lattegotchies objectAtIndex:0];
//        
//        NSString *name = [[app.getPlayer.lattegotchies objectAtIndex:0] name];
//        
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle: @"Congratulations :-)"
//                              message: nil
//                              delegate: nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil
//                              ];
//        NSString *msg = [NSString stringWithFormat:@"You fulfilled %@ wish. Thanks!", name];
//        alert.message = msg;
//        [alert show];
//        
//        [latte.wishes removeObject:self];
//        
//        [app updateUI];
//        
//        [self closeWish];
//        
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle: @"Sorry :-("
//                              message: nil
//                              delegate: nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil
//                              ];
//        NSString *msg = [NSString stringWithFormat:@"Wrond. Try again!"];
//        alert.message = msg;
//        [alert show];
//    }
//    
//    
//    // Remove responder from text field
//    [txtResult resignFirstResponder];
//    
//    // Start calulation
//    
//    NSLog( @"Button clicked." );
//}


- (void) closeWish
{
    
    NSLog( @"Close Wish" );
    [[self getSubView] removeFromSuperview];
}


@end
