//
//  DotImageView.h
//  LAttegotchi
//
//  Created by Alex Jahl on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DotImageView : UIView {
    UIImage * image;
    UIImage * heart;
    UIImage * emotion;
    UIImage * scull;
    UIImage * aBC;
    NSString * aBCString;
    NSArray * emotions;
}

- (void) setImage : (UIImage *) img;
- (void) setEmotion : (UIImage *) img;
- (void) setEmotions : (NSArray *) emos;
- (void) setHeart : (UIImage *) img;
- (void) setABC : (UIImage *) img;
- (void) setABCString : (NSString *) string;
- (void) setScull : (UIImage *) img;

@end
