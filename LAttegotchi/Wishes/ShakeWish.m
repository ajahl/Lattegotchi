
#import "ShakeWish.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"

@implementation ShakeWish


-(void)execute {
    
//    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
//    accelerometer.delegate = self;
//    accelerometer.updateInterval = 1.0;
    
    // Init GUI
    [self createAndInitUI];
    
}

// Daten auswerten (Protokoll: UIAccelerometerDelegate)!
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    NSLog(@"SHAKKKKKKKKKEE");
    
// acceleration.x, acceleration.y, acceleration.z;!
}


- (void)createAndInitUI
{
    // create and add view
    UIView *subView = [self subView];
    
    // Add Text Button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, subView.frame.size.width, 50)];
    [lblDecription setText: self.description];
    [lblDecription setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDecription];
    
    // Add Text Button
    UILabel *lblDistanceTxt = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    
    [lblDistanceTxt setText: [NSString stringWithFormat:@" "]];
    [lblDistanceTxt setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDistanceTxt];
    
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
    [[self subView] removeFromSuperview];
}


- (void) closeWish
{
    NSLog( @"Close Wish" );
    [[self subView] removeFromSuperview];
}


@end
