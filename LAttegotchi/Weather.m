//
//  WeatherWish.m
//  LAttegotchi
//
//  Created by Codecamp on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "Weather.h"

@implementation Weather
static CLLocationManager *locationManager;
static NSTimer* timer;
static enum WeatherType weather = UNKNOWN;

+ (int) getWeather {
    return weather;
}

+ (void) startUpdate {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [Weather updateWeather:timer];
    });
    timer = [NSTimer scheduledTimerWithTimeInterval:60*60
                                             target:[Weather class]
                                           selector:@selector(updateWeather:)
                                           userInfo:nil
                                            repeats:YES];
}


+ (void) setWeather:(int)newWeather {
    if (newWeather < 0 || newWeather > 9) {
        newWeather = 0;
    }
    weather = newWeather;
}

+ (void) stopUpdate {
    [locationManager stopUpdatingLocation];
    if (timer != nil) {
        [timer invalidate];
    }
    timer = nil;
}

+ (void) updateWeather:(NSTimer *) timer {
    @try {
        NSString *latitude = @"51.312711400000000000";
        NSString *longitude = @"9.479746100000057000";
        
        if([CLLocationManager locationServicesEnabled]) {
            CLLocation *curPos = locationManager.location;
            latitude = [[NSNumber numberWithDouble:curPos.coordinate.latitude] stringValue];
            longitude = [[NSNumber numberWithDouble:curPos.coordinate.longitude] stringValue];
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@", latitude, longitude]];
        NSData* data = [NSData dataWithContentsOfURL: url];
        
        NSError *e = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
        
        for (NSDictionary* weatherDict in [json objectForKey:@"weather"]) {
            long theID = [[weatherDict objectForKey:@"id"] intValue];
            switch (theID) {
                case 800:
                {
                    // sky is clear
                    weather = SKYISCLEAR;
                    break;
                }
                    
                case 801:
                {
                    // few clouds
                    weather = FEWCLOUDS;
                    break;
                }
                    
                case 802:
                {
                    // scattered clouds
                    weather = SCATTEREDCLOUDS;
                    break;
                }
                    
                case 803:
                case 804:
                {
                    // broken clouds
                    weather = BROKENCLOUDS;
                    break;
                }
                    
                case 300:
                case 301:
                case 302:
                case 310:
                case 311:
                case 312:
                case 313:
                case 314:
                case 321:
                case 520:
                case 521:
                case 522:
                case 531:
                {
                    // shower rain
                    weather = SHOWERRAIN;
                    break;
                }
                    
                case 500:
                case 501:
                case 502:
                case 503:
                case 504:
                {
                    // Rain
                    weather = RAIN;
                    break;
                }
                    
                case 200:
                case 201:
                case 202:
                case 210:
                case 211:
                case 212:
                case 221:
                case 230:
                case 231:
                case 232:
                {
                    // Thunderstorm
                    weather = THUNDERSTROM;
                    break;
                }
                    
                case 511:
                case 600:
                case 601:
                case 602:
                case 611:
                case 612:
                case 615:
                case 616:
                case 620:
                case 621:
                case 622:
                {
                    // snow
                    weather = SNOW;
                    break;
                }
                    
                case 701:
                case 711:
                case 721:
                case 731:
                case 741:
                case 751:
                case 761:
                case 762:
                case 771:
                case 781:
                {
                    // mist
                    weather = MIST;
                    break;
                }
                    
                default:
                {
                    // unknown
                    weather = UNKNOWN;
                    break;
                }
            }
            break;
        }
    }
    @catch (NSException *exception) {
        weather = UNKNOWN;
    }
}

+ (BOOL) isUpdating {
    if (timer != nil) {
        return YES;
    }
    return NO;
}

@end
