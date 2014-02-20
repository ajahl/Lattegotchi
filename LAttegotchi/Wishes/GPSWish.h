//
//  GPSWish.h
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wish.h"
#import <CoreLocation/CoreLocation.h>


@interface GPSWish : Wish <CLLocationManagerDelegate> {
    // Location
    CLLocationManager *locationManager;
    CLLocation *startLocation;
    
    
    
    // View
    IBOutlet UILabel *lblDistance;
}

@property unsigned int const distance;;

- (void)createAndInitUI;

@end
