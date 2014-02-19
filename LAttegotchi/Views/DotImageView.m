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
    
    [self drawImage];
    [self drawHappiness];
    [self drawHealth];
    
    AppDelegate * app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    NSString * text =  [latte name];
    [self drawText:text:0:0];

//    [self drawMoney: 9 : 52];
    [self drawMoney: 5 : 8];
}

- (void) drawMoney : (int) dX :  (int) dY{
    // draw scull ------------------------------------------------------
    CGSize scullSize = scull.size;
    
    for (int y = 0; y<scullSize.height; y++ ) {
        for (int x = 0; x<scullSize.height; x++) {
            int currentY = dY+1+y;
            int currentX = dX+x;
            
            if( [self isPixelSet:scull :x :y]) {
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
    if(!aBCString)
        return;
    
    int rows = 16;
    NSRange range = [aBCString rangeOfString:cHar];
    int abcIndex = range.location;
    int abcIndexY =  abcIndex / rows * 8;
    int abcIndexX = abcIndex % rows  * 5;
    
    for (int y = 0; y < 8; y++ ) {
        for (int x = 0; x < 5 ; x++) {
            if( ![self isPixelSet:aBC :x +abcIndexX :y +abcIndexY]) {
                [self drawDot:x+ (matrixX*5)+dX :y+ (matrixY*8)+dY:[UIColor blackColor]];
            }
        }
    }
}

-(void) drawImage {
    
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
}

-(void) drawHealth {
    
    // draw health ------------------------------------------------------
    int healthValue = [[self getLAtte] health];
    int health = healthValue* DOT_MATRIX / 100;
    
    for (int y = DOT_MATRIX; y>DOT_MATRIX-health+5; y-- ) {
        for (int x = 0; x<5; x++) {
            [self drawDot:x :y :[UIColor blackColor]];
        }
    }
    
    // draw heart ------------------------------------------------------
    CGSize heartSize = heart.size;
    
    for (int y = 0; y<heartSize.height; y++ ) {
        for (int x = 0; x<heartSize.height; x++) {
            int currentY = DOT_MATRIX-health+y;
            
            if( [self isPixelSet:heart :x :y]) {
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
    int happiness = happinessValue* (DOT_MATRIX) / 100;

    for (int y = DOT_MATRIX; y>DOT_MATRIX-happiness+5; y-- ) {
        for (int x = DOT_MATRIX-5; x<DOT_MATRIX; x++) {
            [self drawDot:x :y :[UIColor blackColor]];
        }
    }
    
    // draw smily -------------------------------------------------------
    int emoIndex =  happinessValue / 34;
    UIImage * eMotion = [UIImage imageNamed:[emotions objectAtIndex:emoIndex]];
    CGSize emoSize = eMotion.size;
    
    for (int y = 0; y<emoSize.height; y++ ) {
        for (int x = 0; x<emoSize.height; x++) {
            int currentY = DOT_MATRIX-happiness+y;
            int currentX = DOT_MATRIX-eMotion.size.width+x;
            
            if( [self isPixelSet:eMotion :x :y]) {
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
