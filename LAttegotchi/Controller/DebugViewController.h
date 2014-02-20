//
//  DebugViewController.h
//  LAttegotchi
//
//  Created by Christoph Eickhoff on 20.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//


@interface DebugViewController : UIViewController


@property IBOutlet UILabel * levelLabel;
@property IBOutlet UIStepper * levelstepper;

- (IBAction)buttonItem:(id)sender;
- (IBAction)buttonGPS:(id)sender;
- (IBAction)buttonMath:(id)sender;
- (IBAction)buttonPush:(id)sender;
- (IBAction)buttonLetter:(id)sender;
- (IBAction)buttonShake:(id)sender;
- (IBAction)buttonBack:(id)sender;
- (IBAction)buttonMoney:(id)sender;
- (IBAction)buttonHappyHealth:(id)sender;
- (IBAction)switchDebugMode:(id)sender;
- (IBAction)stepperLevel:(id)sender;



@end
