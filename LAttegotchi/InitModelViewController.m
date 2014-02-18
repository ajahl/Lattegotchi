//
//  InitModelAlertViewController.m
//  LAttegotchi
//
//  Created by Codecamp on 18.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "InitModelViewController.h"

#define ANIMATION_DURATION  0.25

@interface InitModelAlertViewController ()

@end

@implementation InitModelAlertViewController

- (id)initWithDelegate:(id<InitModelAlertViewControllerDelegate>)delegate
{
    self = [super initWithNibName:@"InitModelViewController" bundle:nil];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.,
}

- (void)viewDidDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) btnOkayTap:(id)sender {
    NSString* playername = _txtFieldPlayerName.text;
    NSString* lattegotchiname = _txtFieldLAttegotchiName.text;
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Error"
                          message: nil
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil
                          ];
    if ([playername length] == 0) {
        alert.message = @"No empty Playername!";
        [alert show];
        return;
    }
    
    if ([lattegotchiname length] == 0) {
        alert.message = @"No empty LAttegotchiname!";
        [alert show];
        return;
    }
    
    [_delegate finishedWithPlayername:playername withLAttegotchiName:lattegotchiname];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction) btnCancelTap:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}

@end
