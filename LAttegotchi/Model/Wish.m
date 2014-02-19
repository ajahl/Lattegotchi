//
//  Wish.m
//  LAttegotchi
//
//  Created by Alex Jahl on 17.02.14.
//  Copyright (c) 2014 Alex Jahl. All rights reserved.
//

#import "Wish.h"
#import "AppDelegate.h"

#define ASCWishName @"wishName"
#define ASCWishDescription @"wishDescription"
#define ASCWishHappiness @"wishHappiness"
#define ASCWishHealth @"wishHealth"
#define ASCWishStarttime @"wishStarttime"
#define ASCWishDeadline @"wishDeadline"
#define ASCWishItems @"wishItems"

@implementation Wish

- (id)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)initWithViewController:(UIViewController *) controller;
{
    _viewController = controller;
    AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    UIView *rootView = app.window.rootViewController.view;
        
        
    int hight =rootView.frame.size.height-292;
    CGRect bounds = CGRectMake(0, 292, rootView.frame.size.width, hight);
        
    _subView= [[UIView alloc] initWithFrame:bounds];
    [_subView setBackgroundColor: [UIColor whiteColor]];
    [rootView addSubview:_subView];

}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCWishName];
    [aCoder encodeObject:self.discription forKey:ASCWishDescription];
    [aCoder encodeInt:self.happiness forKey:ASCWishHappiness];
    [aCoder encodeInt:self.health forKey:ASCWishHealth];
    [aCoder encodeObject:self.starttime forKey:ASCWishStarttime];
    [aCoder encodeObject:self.deadline forKey:ASCWishDeadline];
    [aCoder encodeObject:self.items forKey:ASCWishItems];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:ASCWishName];
        _discription = [aDecoder decodeObjectForKey:ASCWishDescription];
        _happiness = [aDecoder decodeIntForKey:ASCWishHappiness];
        _health = [aDecoder decodeIntForKey:ASCWishHealth];
        _starttime = [aDecoder decodeObjectForKey:ASCWishStarttime];
        _deadline = [aDecoder decodeObjectForKey:ASCWishDeadline];
        _items = [aDecoder decodeObjectForKey:ASCWishItems];
    }
    return self;
}

-(NSString *)getName {
    return _name;
}

-(NSString *)getSubText {
    return [self getSubText:-1];
}

-(NSString *) getSubText:(int)usage {
    unichar heart = 0x2665;
    unichar smiley = 0x263A;
    
    NSString *subText = @"";
    subText = [subText stringByAppendingFormat:@"%C ±%d", heart, _health];
    subText = [subText stringByAppendingFormat:@"\t%C ±%d", smiley, _happiness];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *deadline = [dateFormat stringFromDate:_deadline];
    subText = [subText stringByAppendingFormat:@"\t%@", deadline];
    
    return subText;
}

-(UIViewController *)getViewController {
    return _viewController;
}

-(UIView *)getSubView {
    return _subView;
}

-(void)execute {
    
}

@end
