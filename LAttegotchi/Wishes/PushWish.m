
#import "PushWish.h"
#import "AppDelegate.h"

#define TIME_TIMER_TRIGGER   1  /* seconds */

@implementation PushWish
@synthesize lblSucceed;

// start methode of this wish
-(void)execute {
    
    // init counter variables
    timeCounter = 0;
    clickCounter = 0;
    
    // init timer
    [NSTimer scheduledTimerWithTimeInterval:TIME_TIMER_TRIGGER
                    target:self
                    selector:@selector(gameLoop:)
                    userInfo:nil
                    repeats:YES];
    
    // init gui
    [self createAndInitUI];
    
}

// called from timer every TIME_TIMER_TRIGGER seconds
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

// create and init gui
- (void)createAndInitUI
{
    
    // create and add view
    UIView *subView = [self subView];
    
    // Add Text Button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, subView.frame.size.width, 50)];
    [lblDecription setText: self.discription];
    [lblDecription setTextColor: [UIColor orangeColor]];
    [subView addSubview: lblDecription];
    
    // Add Text Button
    lblSucceed = [[UILabel alloc] initWithFrame:CGRectMake(subView.frame.size.width - 50, 50, subView.frame.size.width, 50)];
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

//
- (void) createNewField {
    
    UIView *subView = [self subView];
    
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

//
- (void) removeField {
    [btn removeFromSuperview];
}

//
- (void) clickedField: (id)sender
{
    clickCounter++;
    lblSucceed.text = [NSString stringWithFormat:@"%i", clickCounter];
    
    [self removeField];
    timeCounter = 0;
    
    if (clickCounter >= self.numOfpush) {
        
        [self success];
        
        [[self subView] removeFromSuperview];
    }
}

- (void) clickedReturn: (id)sender
{
    [[self subView] removeFromSuperview];
}

@end
