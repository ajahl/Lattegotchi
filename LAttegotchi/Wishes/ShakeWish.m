
#import "ShakeWish.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"

@implementation ShakeWish
@synthesize progressView = _progressView;


-(void)execute {
    

    
    // Init GUI
    [self createAndInitUI];
    
}




- (void)createAndInitUI
{
    // create and add view
    UIView *subView = [self subView];
    
    // create progress view
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.frame = CGRectMake(20, 20, subView.frame.size.width-40, 50);
    self.progressView.progress = 0.0;
    [subView addSubview: self.progressView];
    
    
    // add text button
    UILabel *lblDecription = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, subView.frame.size.width, 50)];
    [lblDecription setText: self.discription];
    [lblDecription setTextColor: [UIColor colorWithRed:0 green:202.0f/255.0f blue:1.0f/255.0f alpha:1.0f]];
    [subView addSubview: lblDecription];
    
    
    // add return button
    CGRect buttonFrame = CGRectMake( 10, subView.frame.size.height-30, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"Back" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button addTarget: self
               action: @selector(clickedReturn:)
     forControlEvents: UIControlEventTouchDown];
    [subView addSubview: button];
}


- (void) clickedReturn: (id)sender
{
    NSLog( @"Button clicked." );
    [[self subView] removeFromSuperview];
}




@end
