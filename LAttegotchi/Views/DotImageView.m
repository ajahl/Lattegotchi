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
int START_X = 0;
int START_Y = 0;

float dotSize = 1;
int padding = 1;


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
    
    // draw dotmatrix ------------------------------------------------------
    for (int y = 0; y<DOT_MATRIX; y++ ) {
        for (int x = 0; x<DOT_MATRIX; x++) {
            if( [self isPixelSet:image :x :y]) {
                [self drawDot:x :y :[UIColor greenColor]];
            }
            else {
                [self drawDot:x :y :[UIColor blackColor]];
            }
        }
    }
    
    // draw happiness ------------------------------------------------------
    int happiness = [[self getLAtte] happiness];
    happiness = happiness* (DOT_MATRIX) / 100;
    
    for (int y = DOT_MATRIX-1; y>DOT_MATRIX-happiness; y-- ) {
         for (int x = DOT_MATRIX-5; x<DOT_MATRIX; x++) {
             [self drawDot:x :y :[UIColor blackColor]];
         }
    }
    
    // draw smily -------------------------------------------------------
    CGSize emoSize = emotion.size;
    for (int y = 0; y<emoSize.height; y++ ) {
        for (int x = 0; x<emoSize.height; x++) {
            if( [self isPixelSet:emotion :x :y]) {
                [self drawDot:x :y + happiness-emoSize.height :[UIColor greenColor]];
            }
            else {
                [self drawDot:x :y + happiness-emoSize.height :[UIColor blackColor]];
            }
        }
    }
    
    // draw health ------------------------------------------------------
    int health = [[self getLAtte] health];
    health = health* DOT_MATRIX / 100;
    
    for (int y = DOT_MATRIX-5; y>DOT_MATRIX-health; y-- ) {
        for (int x = 0; x<5; x++) {
            [self drawDot:x :y :[UIColor blackColor]];
        }
    }
    
    // draw heart ------------------------------------------------------
    CGSize heartSize = heart.size;
    for (int y = 0; y<heartSize.height; y++ ) {
        for (int x = 0; x<heartSize.height; x++) {
            if( [self isPixelSet:heart :x :y]) {
                [self drawDot:DOT_MATRIX -heartSize.height + x :y + health-heartSize.height :[UIColor greenColor]];
            }
            else {
                [self drawDot:DOT_MATRIX -heartSize.height + x :y + health-heartSize.height :[UIColor blackColor]];
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
