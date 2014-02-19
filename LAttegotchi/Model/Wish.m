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

- (id)initViewController:(UIViewController *) controller
{
    self = [super init];
    if (self) {
        _viewController = controller;
        AppDelegate * app = (AppDelegate*) [[UIApplication sharedApplication]delegate];
        UIView *rootView = app.window.rootViewController.view;
        
        
        int hight =rootView.frame.size.height/2;
        CGRect bounds = CGRectMake(0, hight, rootView.frame.size.width, hight+100);
        
        _subView= [[UIView alloc] initWithFrame:bounds];
        [_subView setBackgroundColor: [UIColor yellowColor]];
        [rootView addSubview:_subView];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:ASCWishName];
    [aCoder encodeObject:self.discription forKey:ASCWishDescription];
    [aCoder encodeInt:self.happiness forKey:ASCWishHappiness];
    [aCoder encodeInt:self.health forKey:ASCWishHealth];
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
        _deadline = [aDecoder decodeObjectForKey:ASCWishDeadline];
        _items = [aDecoder decodeObjectForKey:ASCWishItems];
    }
    return self;
}

-(NSString *)getName {
    return _name;
}



-(NSString *)getDiscription {
    return _discription;
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
