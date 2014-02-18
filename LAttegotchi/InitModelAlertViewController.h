//
//  InitModelAlertViewController.h
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitModelAlertViewController : UIViewController

-(void)showCustomAlertInView:(UIView *)targetView;
-(void)removeCustomAlertFromView;
-(void)removeCustomAlertFromViewInstantly;
-(void)removeOkayButton:(BOOL)shouldRemove;
-(void)removeCancelButton:(BOOL)shouldRemove;
-(BOOL)isOkayButtonRemoved;
-(BOOL)isCancelButtonRemoved;

- (IBAction) btnOkayTap:(id)sender;
- (IBAction) btnCancelTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UITextField* txtFieldPlayerName;
@property (weak, nonatomic) IBOutlet UITextField* txtFieldLAttegotchiName;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnOK;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *flexSpace;

@end
