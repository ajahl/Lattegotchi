//
//  MysteryMathWish.h
//  LAttegotchi
//
//  Created by Codecamp on 19.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Wish.h"

@interface MysteryMathWish : Wish {
    
    IBOutlet UILabel *lblEquation;
    IBOutlet UITextField *txtResult;
    
    int num1;
    int num2;
    
}

@end
