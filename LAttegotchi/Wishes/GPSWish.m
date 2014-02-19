//
//  GPSWish.m
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "GPSWish.h"
#import "AppDelegate.h"
#import "LAttegotchi.h"



@implementation GPSWish

-(void)setDistance:(int)dist {
    distance = dist;
}


-(void)execute {
    
    // Init GUI
    [self createAndInitUI];
    
    // Init and start GPS
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
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Congratulations :-)"
                              message: nil
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
        
        AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
        LAttegotchi *latte = [[app getPlayer].lattegotchies objectAtIndex:0];
        
        NSString *name = [[app.getPlayer.lattegotchies objectAtIndex:0] name];
        
        
        
        NSString *msg = [NSString stringWithFormat:@"You fulfilled %@ wish. Thanks!", name];
        alert.message = msg;
        [alert show];
        
        
        [self closeWish];
        
        [latte.wishes removeObject:self];
        
        [app updateUI];

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
    
    NSLog(@"Start gps and get location.");
}

// 
- (void)locationStop
{
    [locationManager stopUpdatingLocation];
    NSLog(@"Stop gps.");
    
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
    
    // Create and add distance label
    lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [lblDistance setText: @"0.0 m"];
    [lblDistance setTextColor: [UIColor orangeColor]];
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

    NSLog( @"Button clicked." );
    [[self getSubView] removeFromSuperview];
}

- (void) closeWish
{
    
    NSLog( @"Close Wish" );
    [self locationStop];
    [[self getSubView] removeFromSuperview];
}


@end
