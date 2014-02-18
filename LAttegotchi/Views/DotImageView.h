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
}

- (void) setImage : (UIImage *) img;
- (void) setEmotion : (UIImage *) img;
- (void) setHeart : (UIImage *) img;

@end
