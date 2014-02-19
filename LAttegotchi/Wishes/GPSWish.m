//
//  GPSWish.m
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "GPSWish.h"


@implementation GPSWish


-(void)execute {
    
    // Init
    
//    UIViewController *viewController = [self parentViewController];
//    int hight =viewController.view.frame.size.height/2;
//    CGRect bounds = CGRectMake(0, hight, viewController.view.frame.size.width, hight+100);
    // init location
    
    CGRect bounds = self.getViewController.view.bounds;
    
    subView= [[UIView alloc] initWithFrame:bounds];
    [subView setBackgroundColor: [UIColor yellowColor]];
    [self.getViewController.view addSubview:subView];

    [self locationInit];
    
}


//
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Init start point if not init
    if (!startLocation) {
        
        startLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
        NSLog(@"init start posion with latitude: %f and longitude: %f", startLocation.coordinate.latitude, startLocation.coordinate.longitude);
        
        return;
    }
    
    
    lblDistance.text = [NSString stringWithFormat:@"%f m", [startLocation distanceFromLocation:newLocation]];
    
    NSLog(@"OldLocation %f %f", startLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    NSLog(@"Distance i meters: %f", [startLocation distanceFromLocation:newLocation]);
    
    if ([startLocation distanceFromLocation:newLocation] >= distance) {
        
        
        [self locationStop];
        
    }
    
}

//
- (void)locationInit
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    NSLog(@"Start gps and get location.");
}

//
- (void)locationStop
{
    [locationManager stopUpdatingLocation];
    NSLog(@"Stop gps.");
    
}


- (void)createAndInitLocationUI:(int)dis{
    
    // init distance
    distance = dis;
    
    // create and add view
//    CGRect bounds = self.view.bounds;
//    
//    subView= [[UIView alloc] initWithFrame:bounds];
//    [subView setBackgroundColor: [UIColor yellowColor]];
//    [self.view addSubview:subView];
//    
//    // create and add distance label
//    CGRect labelFrame = CGRectMake( 10, 40, 100, 30 );
//    lblDistance = [[UILabel alloc] initWithFrame: labelFrame];
//    [lblDistance setText: @"My Label"];
//    [lblDistance setTextColor: [UIColor orangeColor]];
//    [subView addSubview: lblDistance];
//    
//    CGRect buttonFrame = CGRectMake( 10, 80, 100, 30 );
//    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
//    [button setTitle: @"My Button" forState: UIControlStateNormal];
//    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
//    [button addTarget: self
//               action: @selector(buttonClicked:)
//     forControlEvents: UIControlEventTouchDown];
//    [subView addSubview: button];
//    
//    [self.view.window makeKeyAndVisible];
    
    // Init and start gps and location search
    [self locationInit];
    
}

- (void) buttonClicked: (id)sender
{
    NSLog( @"Button clicked." );
    [subView removeFromSuperview];
}


@end
