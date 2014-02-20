//
//  DotImageView.m
//  LAttegotchi
//
//  Created by Alex Jahl on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "DotImageView.h"

#import "AppDelegate.h"
#import "LAttegotchi.h"
#import "DebugViewController.h"
#import "Weather.h"


@implementation DotImageView

#define DOT_MATRIX  64
#define START_X     0
#define START_Y     0

float dotSize = 1;
int padding     = 1;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        padding = ([self frame].size.width -10)/ DOT_MATRIX;
        CGRect rect = [self frame];
        dotSize =(rect.size.width-(DOT_MATRIX+1) * padding) / (DOT_MATRIX/2);
        dotSize = dotSize*2.2f;
        padding = padding+1;
    }
    return self;
}


-(void) drawDot :(int)x : (int)y :(UIColor *) color {
    int matrixX = START_X + (padding) * x;
    int matrixY = START_Y + (padding) * y;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddRect(context, CGRectMake( matrixX, matrixY, dotSize, dotSize));
//  CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
    CGContextFillPath(context);
}

- (void)drawRect:(CGRect)rect {
    self.clearsContextBeforeDrawing = YES;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    // background ----------------------------------------------------------
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    
    [self drawImage];
    [self drawHappiness];
    [self drawHealth];
    
    AppDelegate * app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    NSString * text =  [latte name];
    [self drawText:text:0:0];

//    [self drawMoney: 9 : 52];
    [self drawMoney: 6 : 8];
    [self drawWishes: 6 : 52];
    [self drawWeather: 34: 3];
}

- (void) drawWeather : (int) dX :  (int) dY {
    if (!cloud || !sun)
        return;
    
    enum WeatherType weather = [Weather getWeather];
    
    switch (weather) {
        case SKYISCLEAR:
        {
            CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(sun.CGImage));
            const UInt8* data = CFDataGetBytePtr(pixelData);
            
            CGSize sunSize = sun.size;
            for (int y = 0; y<sunSize.height; y++ ) {
                for (int x = 0; x<sunSize.width; x++) {
                    int currentY = dY+1+y;
                    int currentX = dX+x;
                    
                    if( ![self isPixelSetAt:data :x :y :sun.size])  {
                        [self drawDot:currentX :currentY :[UIColor blackColor]];
                    }
                }
            }
        }
        break;
            
        default:
        {
            CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(sun.CGImage));
            const UInt8* data = CFDataGetBytePtr(pixelData);
            
            CGSize sunSize = sun.size;
            for (int y = 0; y<sunSize.height; y++ ) {
                for (int x = 0; x<sunSize.width; x++) {
                    int currentY = dY+1+y;
                    int currentX = dX+x;
                    
                    if( ![self isPixelSetAt:data :x :y :sun.size])  {
                        [self drawDot:currentX :currentY :[UIColor blackColor]];
                    }
                }
            }
        }
            break;
    }
    
    

}

- (void) drawWishes : (int) dX :  (int) dY{
    // draw wish ------------------------------------------------------
    if (!wishLamp)
        return;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(wishLamp.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    CGSize wishSize = wishLamp.size;
    
    for (int y = 0; y<wishSize.height; y++ ) {
        for (int x = 0; x<wishSize.width; x++) {
            int currentY = dY+1+y;
            int currentX = dX+x;
            
            if( [self isPixelSetAt:data :x :y :wishLamp.size]) {
                [self drawDot:currentX :currentY :[UIColor greenColor]];
            }
            else {
                [self drawDot:currentX :currentY :[UIColor blackColor]];
            }
        }
    }

    
    AppDelegate * app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    NSString * text =  [NSString stringWithFormat:@"%lu", (unsigned long)[latte getActiveWishes].count];
    [self drawText:text:dX+wishLamp.size.width+2 :dY];
}

- (void) drawMoney : (int) dX :  (int) dY{
    // draw scull ------------------------------------------------------
    if (!scull)
        return;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(scull.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    CGSize scullSize = scull.size;
    
    for (int y = 0; y<scullSize.height; y++ ) {
        for (int x = 0; x<scullSize.height; x++) {
            int currentY = dY+1+y;
            int currentX = dX+x;
            
            if( [self isPixelSetAt:data :x :y :scull.size]) {
                [self drawDot:currentX :currentY :[UIColor greenColor]];
            }
            else {
                [self drawDot:currentX :currentY :[UIColor blackColor]];
            }
        }
    }
    
    AppDelegate * app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    NSString * text = [NSString stringWithFormat:@"%d", [[app getPlayer] money]];
    [self drawText:text :dX+6 :dY];
}

- (void) drawText: (NSString * ) text : (int) x : (int) y{
    for (unsigned int i=0; i < [text length]; ++i) {
        NSString *cHar = [NSString stringWithFormat:@"%c" , [text characterAtIndex:i]];
        [self drawChar:cHar:i:0:x:y];
    }
}

-(void) drawChar: (NSString *) cHar : (int) matrixX : (int) matrixY : (int)dX : (int) dY {
    if(!aBCString||!aBC)
        return;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(aBC.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int rows = 16;
    NSRange range = [aBCString rangeOfString:cHar];
    int abcIndex = (int) range.location;
    int abcIndexY =  abcIndex / rows * 8;
    int abcIndexX = abcIndex % rows  * 5;
    
    for (int y = 0; y < 8; y++ ) {
        for (int x = 0; x < 5 ; x++) {
            if( ![self isPixelSetAt:data :x +abcIndexX :y +abcIndexY: aBC.size]) {
                [self drawDot:x+ (matrixX*5)+dX :y+ (matrixY*8)+dY:[UIColor blackColor]];
            }
        }
    }
}

-(void) drawImage {
    if (!image)
        return;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    // draw dotmatrix ------------------------------------------------------
    for (int y = 0; y<DOT_MATRIX; y++ ) {
        for (int x = 0; x<DOT_MATRIX; x++) {
            if( [self isPixelSetAt:data :x :y : image.size]) {
                [self drawDot:x :y :[UIColor greenColor]];
            }
            else {
                [self drawDot:x :y :[UIColor blackColor]];
            }
        }
    }
    
    CFRelease(pixelData);
}

-(void) drawHealth {
    if(!heart)
        return;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(heart.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    
    // draw health ------------------------------------------------------
    int healthValue = [[self getLAtte] health];
    int health = healthValue* (DOT_MATRIX-15) / 100;
    
    for (int y = DOT_MATRIX-6; y>DOT_MATRIX-6-health; y-- ) {
        for (int x = 0; x<5; x++) {
            [self drawDot:x :y :[UIColor blackColor]];
        }
    }
    
    // draw heart ------------------------------------------------------
    CGSize heartSize = heart.size;
    
    for (int y = 0; y<heartSize.height; y++ ) {
        for (int x = 0; x<heartSize.height; x++) {
            int currentY = DOT_MATRIX-health+y-11;
            
            if( [self isPixelSetAt:data :x :y :heart.size]) {
                [self drawDot:x :currentY :[UIColor greenColor]];
            }
            else {
                [self drawDot:x :currentY :[UIColor blackColor]];
            }
        }
    }
}

-(void) drawHappiness {
    
    
    // draw happiness ------------------------------------------------------
    int happinessValue = [[self getLAtte] happiness];
    int happiness = happinessValue * (DOT_MATRIX-15) / 100;

    for (int y = DOT_MATRIX-6; y>DOT_MATRIX-6-happiness; y-- ) {
        for (int x = DOT_MATRIX-5; x<DOT_MATRIX; x++) {
            [self drawDot:x :y :[UIColor blackColor]];
        }
    }
    
    // draw smily -------------------------------------------------------
    int emoIndex =  happinessValue / 34;
    UIImage * eMotion = [UIImage imageNamed:[emotions objectAtIndex:emoIndex]];
    CGSize emoSize = eMotion.size;
    if(!eMotion)
        return;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(eMotion.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    for (int y = 0; y<emoSize.height; y++ ) {
        for (int x = 0; x<emoSize.height; x++) {
            int currentY = DOT_MATRIX-happiness+y-11;
            int currentX = DOT_MATRIX-eMotion.size.width+x;
            
            if( [self isPixelSetAt:data :x :y :eMotion.size]) {
                [self drawDot:currentX :currentY :[UIColor greenColor]];
            }
            else {
                [self drawDot:currentX :currentY :[UIColor blackColor]];
            }
        }
    }
}

-(LAttegotchi *) getLAtte {
    AppDelegate * app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    return latte;
}

- (void) setImage:(UIImage*) img {
    image = img;
    [self setNeedsDisplay];
}

-(void) setEmotion : (UIImage *) img {
    emotion = img;
    [self setNeedsDisplay];
}

- (void) setEmotions : (NSArray *) emos {
    emotions = emos;
}

- (void) setHeart : (UIImage *) img {
    heart = img;
    [self setNeedsDisplay];
}

- (void) setABC : (UIImage *) img {
    aBC = img;
    [self setNeedsDisplay];
}

- (void) setABCString : (NSString *) string {
    aBCString = string;
    [self setNeedsDisplay];
}

- (void) setScull : (UIImage *) img {
    scull = img;
    [self setNeedsDisplay];
}

- (void) setWishLamp : (UIImage *) img {
    wishLamp = img;
    [self setNeedsDisplay];
}

- (void) setSun : (UIImage *) img {
    sun = img;
    [self setNeedsDisplay];
}

- (void) setCloud : (UIImage *) img {
    cloud = img;
    [self setNeedsDisplay];
}


- (BOOL)isPixelSetAt: (const UInt8 * ) data : (int) x : (int) y : (CGSize) size  {
    
    int pixelInfo = ((size.width  * y) + x ) * 4;
    
    UInt8 red = data[pixelInfo];
    UInt8 green = data[(pixelInfo + 1)];
    UInt8 blue = data[pixelInfo + 2];
    UInt8 alpha = data[pixelInfo + 3];
    
    if (alpha && red != 255 && blue != 255 && green != 255)
        return NO;
    else
        return YES;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    int x = point.x;
    int y = point.y;
    switch (debugTouchCount) {
        case 0:{
            if (x>200&&y < 100) {
                debugTouchCount++;
            }
            break;
        }
        case 1:{
            if (x>200&&y > 100) {
                debugTouchCount++;
            }
            break;
        }
        case 2:{
            if (x<200&&y > 100) {
                NSLog(@"%f , %f" , point.x,point.y);
                debugTouchCount = 0;

                DebugViewController *debug = [[DebugViewController alloc] initWithNibName: @"DebugViewController" bundle:nil];
                 AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
                [[app window].rootViewController presentViewController:debug animated:YES completion:NULL];
                
            }
            break;
        }
            
        default:{
            debugTouchCount = 0;
            break;
        }
            
    }
    
    
}

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}
@end
