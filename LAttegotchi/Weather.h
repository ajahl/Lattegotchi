//
//  WeatherWish.h
//  LAttegotchi
//
//  Created by Codecamp on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

@interface Weather : NSObject

enum WeatherType {
    SKYISCLEAR,
    FEWCLOUDS,
    SCATTEREDCLOUDS,
    BROKENCLOUDS,
    SHOWERRAIN,
    RAIN,
    THUNDERSTROM,
    SNOW,
    MIST,
    UNKNOWN
};

+ (void) setWeather:(int)newWeather;
+ (int) getWeather;

+ (void) startUpdate;
+ (void) stopUpdate;
+ (BOOL) isUpdating;

@end
