//
//  InitModelAlertViewController.m
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "InitModelAlertViewController.h"

#define OK_BUTTON_TAG       888
#define CANCEL_BUTTON_TAG   999
#define ANIMATION_DURATION  0.25

@interface InitModelAlertViewController ()
-(void)addOrRemoveButtonWithTag:(int)tag andActionToPerform:(BOOL)shouldRemove;
@end

@implementation InitModelAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [_btnOK setTag:OK_BUTTON_TAG];
        [_btnCancel setTag:CANCEL_BUTTON_TAG];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCustomAlertInView:(UIView *)targetView {
    CGFloat statusBarOffset;
    
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        // If the status bar is not hidden then we get its height and keep it to the statusBarOffset variable.
        // However, there is a small trick here that needs to be done.
        // In portrait orientation the status bar size is 320.0 x 20.0 pixels.
        // In landscape orientation the status bar size is 20.0 x 480.0 pixels (or 20.0 x 568.0 pixels on iPhone 5).
        // We need to check which is the smallest value (width or height). This is the value that will be kept.
        // At first we get the status bar size.
        CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
        if (statusBarSize.width < statusBarSize.height) {
            // If the width is smaller than the height then this is the value we need.
            statusBarOffset = statusBarSize.width;
        }
        else{
            // Otherwise the height is the desired value that we want to keep.
            statusBarOffset = statusBarSize.height;
        }
    }
    else{
        // Otherwise set it to 0.0.
        statusBarOffset = 0.0;
    }
    
    
    // Declare the following variables that will take their values
    // depending on the orientation.
    CGFloat width, height, offsetX, offsetY;
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
        [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        // If the orientation is landscape then the width
        // gets the targetView's height value and the height gets
        // the targetView's width value.
        width = targetView.frame.size.height;
        height = targetView.frame.size.width;
        
        offsetX = -statusBarOffset;
        offsetY = 0.0;
    }
    else{
        // Otherwise the width is width and the height is height.
        width = targetView.frame.size.width;
        height = targetView.frame.size.height;
        
        offsetX = 0.0;
        offsetY = -statusBarOffset;
    }
    
    // Set the view's frame and add it to the target view.
    [self.view setFrame:CGRectMake(targetView.frame.origin.x, targetView.frame.origin.y, width, height)];
    [self.view setFrame:CGRectOffset(self.view.frame, offsetX, offsetY)];
    [targetView addSubview:self.view];
    
    
    // Set the initial frame of the message view.
    // It should be out of the visible area of the screen.
    [_viewContent setFrame:CGRectMake(0.0, -_viewContent.frame.size.height, _viewContent.frame.size.width, _viewContent.frame.size.height)];
    
    // Animate the display of the message view.
    // We change the y point of its origin by setting it to 0 from the -height value point we previously set it.
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [_viewContent setFrame:CGRectMake(0.0, 0.0, _viewContent.frame.size.width, _viewContent.frame.size.height)];
    [UIView commitAnimations];
}

-(void)removeCustomAlertFromView {
    // Animate the message view dissapearing.
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [_viewContent setFrame:CGRectMake(0.0, -_viewContent.frame.size.height, _viewContent.frame.size.width, _viewContent.frame.size.height)];
    [UIView commitAnimations];
    
    // Remove the main view from the super view as well after the animation is finished.
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:ANIMATION_DURATION];
}

-(void)removeCustomAlertFromViewInstantly {
    [self.view removeFromSuperview];
}

-(void)removeOkayButton:(BOOL)shouldRemove{
    if ([self isOkayButtonRemoved] != shouldRemove) {
        [self addOrRemoveButtonWithTag:OK_BUTTON_TAG andActionToPerform:shouldRemove];
    }
}


-(void)removeCancelButton:(BOOL)shouldRemove {
    if ([self isCancelButtonRemoved] != shouldRemove) {
        [self addOrRemoveButtonWithTag:CANCEL_BUTTON_TAG andActionToPerform:shouldRemove];
    }
}

-(BOOL)isOkayButtonRemoved {
    if ([[_toolbar items] indexOfObject:_btnOK] == NSNotFound) {
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL)isCancelButtonRemoved {
    if ([[_toolbar items] indexOfObject:_btnCancel] == NSNotFound) {
        return YES;
    }
    else{
        return NO;
    }
}

-(void)addOrRemoveButtonWithTag:(int)tag andActionToPerform:(BOOL)shouldRemove{
    NSMutableArray *items = [[_toolbar items] mutableCopy];
    
    int flexSpaceIndex = [items indexOfObject:_flexSpace];
    int btnIndex = (tag == OK_BUTTON_TAG) ? flexSpaceIndex + 1 : 0;
    
    if (shouldRemove) {
        [items removeObjectAtIndex:btnIndex];
    }
    else{
        if (tag == OK_BUTTON_TAG) {
            [items insertObject:_btnOK atIndex:btnIndex];
        }
        else{
            [items insertObject:_btnCancel atIndex:btnIndex];
        }
    }
    
    [_toolbar setItems:(NSArray *)items];
}

- (IBAction) btnOkayTap:(id)sender {
    
}

- (IBAction) btnCancelTap:(id)sender {
    
}

@end
