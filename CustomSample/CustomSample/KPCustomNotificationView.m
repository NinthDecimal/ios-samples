//
//  KPCustomNotificationView.m
//  Kiip
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Kiip, Inc. All rights reserved.
//

#import "KPCustomNotificationView.h"
#define HEIGHT 46

@implementation KPCustomNotificationView

- (id)initWithFrame:(CGRect)frame {    
    self = [super initWithFrame:frame];
    if (self) {
        
        //sets up notification's objects' frames
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(90, 9, 200, 20)];
        self.message = [[UILabel alloc]initWithFrame:CGRectMake(75, 20, 220, 20)];
        
        //sets up font size, font type, text color
        self.title.font = [UIFont boldSystemFontOfSize:13];
        self.message.font = [UIFont systemFontOfSize:11];
        self.title.textColor = [UIColor whiteColor];
        self.message.textColor = [UIColor whiteColor];
        
        //sets background color of notification objects
        self.title.backgroundColor = [UIColor clearColor];
        self.message.backgroundColor = [UIColor clearColor];
        self.icon.backgroundColor = [UIColor clearColor];
        
        
        //adds objects to notification
        [self addSubview:self.title];
        [self addSubview:self.message];
        [self addSubview:self.icon];

        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void) didMoveToSuperview {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notificationCustom.png"]];
    }
    else {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CustomBanner-ipad.png"]];
    }
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.superview.bounds), HEIGHT);
}

//called automatically, sets info from poptart to objects
- (void) setPoptart:(KPPoptart *)poptart {
    [super setPoptart:poptart];
    [self.title setText:poptart.notification.title];
    [self.icon setImage:poptart.notification.icon];
    [self.message setText:poptart.notification.message];

}

@end
