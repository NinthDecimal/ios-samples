//
//  KPCustomNotificationView.h
//  Kiip
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Kiip, Inc. All rights reserved.
//

#import <KiipSDK/KPNotificationView.h>

@interface KPCustomNotificationView : KPNotificationView

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *message;
@property (strong, nonatomic) UIImageView *icon;

@end
