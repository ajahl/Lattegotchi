
#import "Wish.h"

@interface MysteryMathWish : Wish {
    
    IBOutlet UILabel *lblEquation;
    IBOutlet UITextField *txtResult;
}

@property unsigned int const num1;
@property unsigned int const num2;
@property unsigned int const range;

@end
