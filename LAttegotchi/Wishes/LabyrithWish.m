//
//  LabyrithWish.m
//  LAttegotchi
//
//  Created by Codecamp on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "LabyrithWish.h"

@implementation LabyrithWish

- (void)createAndInitUI
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:3];
    [tapRecognizer setDelegate:self];
    [self.viewController.view addGestureRecognizer:tapRecognizer];

}

- (void) tapped: (id)sender {
    NSLog(@" ############### ");
}


@end
