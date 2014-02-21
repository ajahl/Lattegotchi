
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

@property unsigned int const distance;

- (void)createAndInitUI;

@end
