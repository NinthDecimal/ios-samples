//
//  KPCustomButton.m
//  SimpleSample
//
//  Created by Ash Bhat on 7/11/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <KiipSDK/KPPoptart.h>

#import "KPCustomButton.h"

@implementation KPCustomButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBackgroundImage:[[UIImage imageNamed:@"button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)] forState:UIControlStateNormal];
        
        //sets up button's objects' frames
        self.notificationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
        self.notificationTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 9, 200, 20)];
        self.notificationMessage = [[UILabel alloc]initWithFrame:CGRectMake(64, 20, 220, 20)];
        
        //sets up font size, font type, text color
        self.notificationTitle.font = [UIFont boldSystemFontOfSize:13];
        self.notificationMessage.font = [UIFont systemFontOfSize:11];
        self.notificationTitle.textColor = [UIColor whiteColor];
        self.notificationMessage.textColor = [UIColor whiteColor];
        
        //sets background color of button objects
        self.notificationTitle.backgroundColor = [UIColor clearColor];
        self.notificationMessage.backgroundColor = [UIColor clearColor];
        self.notificationIcon.backgroundColor = [UIColor clearColor];
        
        //adds objects to button
        [self addSubview:self.notificationTitle];
        [self addSubview:self.notificationMessage];
        [self addSubview:self.notificationIcon];
    }
    return self;
}

//called in ViewController, sets info from poptart to objects
- (void)setPoptart:(KPPoptart *)poptart {
    [self.notificationTitle setText:poptart.notification.title];
    [self.notificationIcon setImage:poptart.notification.icon];
    [self.notificationMessage setText:poptart.notification.message];
}
@end
