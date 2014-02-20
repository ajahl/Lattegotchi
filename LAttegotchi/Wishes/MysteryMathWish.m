
#import "MysteryMathWish.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"

@implementation MysteryMathWish

//
-(void)execute {
    
    // Init GUI
    [self createAndInitUI];
}

//
- (void)createAndInitUI
{
    // create and add view
    UIView *subView = [self subView];
    
    // Add Text Button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, subView.frame.size.width, 50)];
    [lblDecription setText: self.discription];
    [lblDecription setTextColor: [UIColor colorWithRed:0 green:202.0f/255.0f blue:1.0f/255.0f alpha:1.0f]];
    [subView addSubview: lblDecription];
    
    // Add Text Button
    UILabel *lblDistanceTxt = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 50)];
    
    [lblDistanceTxt setText: [NSString stringWithFormat:@" %i + %i = ", _num1, _num2]];
    [lblDistanceTxt setTextColor: [UIColor colorWithRed:0 green:202.0f/255.0f blue:1.0f/255.0f alpha:1.0f]];
    [subView addSubview: lblDistanceTxt];
    
    // Create and add distance label
    txtResult  = [[UITextField alloc] initWithFrame:CGRectMake(100, 50, 100, 50)];
    [txtResult setTextColor: [UIColor colorWithRed:0 green:202.0f/255.0f blue:1.0f/255.0f alpha:1.0f]];
    
    // Add
    [txtResult addTarget: self
               action: @selector(textFieldDidBeginEditing:)
     forControlEvents: UIControlEventEditingDidBegin];
    
    [txtResult addTarget: self
                  action: @selector(textFieldDidEndEditing:)
        forControlEvents: UIControlEventEditingDidEnd];
    [subView addSubview: txtResult];
    
    [txtResult setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Add return button
    CGRect buttonFrame = CGRectMake( 10, subView.frame.size.height-30, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"Back" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button addTarget: self
               action: @selector(buttonClicked:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: button];
    
    // Add input button
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
    [[self subView] removeFromSuperview];
}

- (void) buttonInputClicked: (id)sender
{
    if ([txtResult.text intValue] == _num1 + _num2) {
        [[self subView] removeFromSuperview];
        [self success];
        
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
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [self subView].frame = CGRectMake(0,-10,320,400);
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [self subView].frame = CGRectMake(0, 292,320,400);
    [UIView commitAnimations];
}


@end
