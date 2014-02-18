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

    
    int padding = ([self frame].size.width -10)/ DOT_MATRIX;
    
    float radius = (rect.size.width-(DOT_MATRIX+1) * padding) / (DOT_MATRIX/2); // radius
    
    padding = padding+1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]); // background
    CGContextFillRect(context, rect); // background color
    
    // draw dotmatrix ------------------------------------------------------
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]); // dot
    
    for (int y = 0; y<DOT_MATRIX; y++ ) {
        
        for (int x = 0; x<DOT_MATRIX; x++) {
            
            int currentX = START_X + (padding)*x;
            int currentY = START_Y + (padding)*y;
            
            CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
            CGContextFillPath(context);
        }
    }
    
    // draw happiness ------------------------------------------------------
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    
    int health = [[self getLAtte] happiness];
    
    for (int y = DOT_MATRIX-1; y>health; y-- ) {
    
        int currentX = START_X + (padding) * (DOT_MATRIX-1);
        int currentY = START_Y + (padding) * y;
        
        CGContextAddArc(context, currentX, currentY, radius, 0, M_PI*2, 0);
        CGContextFillPath(context);
    }
}




-(LAttegotchi *) getLAtte {
    AppDelegate * app = [[UIApplication sharedApplication]delegate];
    LAttegotchi * latte  = [[[app getPlayer] lattegotchies ] objectAtIndex:0];
    return latte;
}


@end
