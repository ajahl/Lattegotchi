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

@implementation DotImageView

int DOT_MATRIX = 64;
int START_X = 2;
int START_Y = 25;

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        
//        
//    }
//    return self;
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.clearsContextBeforeDrawing = YES;
    int padding = ([self frame].size.width -10)/ DOT_MATRIX;
    
    float radius = (rect.size.width-(DOT_MATRIX+1) * padding) / (DOT_MATRIX/2); // radius
    
    padding = padding+1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]); // background
    CGContextFillRect(context, rect);
    
    // draw dotmatrix ------------------------------------------------------
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    for (int y = 0; y<DOT_MATRIX; y++ ) {
        
        for (int x = 0; x<DOT_MATRIX; x++) {
            
            if( [self isPixelSet:image :x :y]) {
                CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
                
            }
            else {
                CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
            }
            
            int currentX = START_X + (padding)*x;
            int currentY = START_Y + (padding)*y;
            
//            CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
            CGContextAddRect(context, CGRectMake( currentX, currentY, radius*2.2f, radius*2.2f));
            CGContextFillPath(context);
        }
    }
    
    // draw happiness ------------------------------------------------------
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    int happiness = [[self getLAtte] happiness];
    happiness = happiness* DOT_MATRIX / 100;
    
    for (int y = DOT_MATRIX-1; y>DOT_MATRIX-happiness; y-- ) {
        
         for (int x = DOT_MATRIX-5; x<DOT_MATRIX; x++) {
             
             int currentX = START_X + (padding) * x;//(DOT_MATRIX-1);
             int currentY = START_Y + (padding) * y;
        
             //        CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
             CGContextAddRect(context, CGRectMake( currentX, currentY, radius*2.2f, radius*2.2f));
             CGContextFillPath(context);
         }
    }
    
    // draw smily -------------------------------------------------------
    CGSize emoSize = emotion.size;
    for (int y = 0; y<emoSize.height; y++ ) {
        for (int x = 0; x<emoSize.height; x++) {
            if( [self isPixelSet:emotion :x :y]) {
                CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
            }
            else {
                CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
            }
            
            int currentX = START_X + (padding)*x;
            int currentY = START_Y + (padding)*(y + happiness-emoSize.height);
            
            //            CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
            CGContextAddRect(context, CGRectMake( currentX, currentY, radius*2.2f, radius*2.2f));
            CGContextFillPath(context);
        }
    }
    
    
    // draw health ------------------------------------------------------
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    int health = [[self getLAtte] health];
    health = health* DOT_MATRIX / 100;
    
    for (int y = DOT_MATRIX-1; y>DOT_MATRIX-health; y-- ) {
        
        for (int x = 0; x<5; x++) {
            
            int currentX = START_X + (padding) * x;//(DOT_MATRIX-1);
            int currentY = START_Y + (padding) * y;

            //        CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
            CGContextAddRect(context, CGRectMake( currentX, currentY, radius*2.2f, radius*2.2f));
            CGContextFillPath(context);
        }
    }
    
    // draw heart ------------------------------------------------------
    CGSize heartSize = heart.size;
    for (int y = 0; y<heartSize.height; y++ ) {
        for (int x = 0; x<heartSize.height; x++) {
            if( [self isPixelSet:heart :x :y]) {
                CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
            }
            else {
                CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
            }
            
            int currentX = START_X + (padding)*(DOT_MATRIX -heartSize.height + x);
            int currentY = START_Y + (padding)*(y + health-heartSize.height);
            
            //            CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
            CGContextAddRect(context, CGRectMake( currentX, currentY, radius*2.2f, radius*2.2f));
            CGContextFillPath(context);
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

- (void) setHeart : (UIImage *) img {
    heart = img;
    [self setNeedsDisplay];
}

- (BOOL)isPixelSet:(UIImage *) img : (int) x :(int) y {
    
    if ( !img )
        return NO;
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(img.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((img.size.width  * y) + x ) * 4;
    
    UInt8 red = data[pixelInfo];
    UInt8 green = data[(pixelInfo + 1)];
    UInt8 blue = data[pixelInfo + 2];
    UInt8 alpha = data[pixelInfo + 3];
    CFRelease(pixelData);

    if (alpha && red != 255 && blue != 255 && green != 255)
        return NO;
    else
        return YES;
    
}

@end
