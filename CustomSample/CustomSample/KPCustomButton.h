//
//  KPCustomButton.h
//  SimpleSample
//
//  Created by Ash Bhat on 7/11/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPCustomButton : UIButton

@property (strong, nonatomic) UILabel *notificationTitle;
@property (strong, nonatomic) UILabel *notificationMessage;
@property (strong, nonatomic) UIImageView *notificationIcon;

-(void)setPoptart:(KPPoptart *)poptart;

@end
