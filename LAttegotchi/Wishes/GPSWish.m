
#import "GPSWish.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"

//#define DEBUG_GPSWISH

@implementation GPSWish

-(void)execute {
    
    // Init GUI
    [self createAndInitUI];
    
    // Init and start GPS
    [self locationInit];
    
}

// Call if location is updated
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Init start point if not init
    if (!startLocation) {
        
        startLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
#ifdef DEBUG_GPSWISH
        NSLog(@"init start posion with latitude: %f and longitude: %f", startLocation.coordinate.latitude, startLocation.coordinate.longitude);
#endif
        return;
    }
    
    
    lblDistance.text = [NSString stringWithFormat:@"%f m", [startLocation distanceFromLocation:newLocation]];

#ifdef DEBUG_GPSWISH
    NSLog(@"OldLocation %f %f", startLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    NSLog(@"Distance i meters: %f", [startLocation distanceFromLocation:newLocation]);
#endif
    
    if ([startLocation distanceFromLocation:newLocation] >= _distance) {
        [[self subView] removeFromSuperview];
        [self success];
        
        [self locationStop];
        
    }
    
}

// Init location and gps
- (void)locationInit
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

#ifdef DEBUG_GPSWISH
    NSLog(@"Start gps and get location.");
#endif

}

// stop location
- (void)locationStop
{
    [locationManager stopUpdatingLocation];
#ifdef DEBUG_GPSWISH
    NSLog(@"Stop gps.");
#endif
}

// create and init gui with objects
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
    [lblDistanceTxt setText: @"Distance: "];
    [lblDistanceTxt setTextColor: [UIColor colorWithRed:0 green:202.0f/255.0f blue:1.0f/255.0f alpha:1.0f]];
    [subView addSubview: lblDistanceTxt];
    
    // Create and add distance label
    lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 50)];
    [lblDistance setText: @"0.0 m"];
    [lblDistance setTextColor: [UIColor colorWithRed:0 green:202.0f/255.0f blue:1.0f/255.0f alpha:1.0f]];
    [subView addSubview: lblDistance];
    
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
    [[self subView] removeFromSuperview];
}

- (BOOL)isAvailable {
    return [CLLocationManager locationServicesEnabled];
}

@end
