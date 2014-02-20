
#import "Wish.h"

@interface PushWish : Wish {
    IBOutlet UIButton *btn;
    int timeCounter;
    int clickCounter;
}

@property unsigned int const numOfpush;
@property (nonatomic, retain) IBOutlet UILabel *lblSucceed;


@end
