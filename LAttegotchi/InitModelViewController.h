//
//  InitModelAlertViewController.h
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InitModelAlertViewControllerDelegate <NSObject>
- (void)finishedWithPlayername:(NSString*)playername withLAttegotchiName:(NSString*)lattegotchiname;
@end

@interface InitModelAlertViewController : UIViewController <UITextFieldDelegate>


- (id)initWithDelegate:(id<InitModelAlertViewControllerDelegate>)delegate;

- (IBAction) btnOkayTap:(id)sender;

@property (nonatomic, retain) id<InitModelAlertViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField* txtFieldPlayerName;
@property (weak, nonatomic) IBOutlet UITextField* txtFieldLAttegotchiName;

@end
