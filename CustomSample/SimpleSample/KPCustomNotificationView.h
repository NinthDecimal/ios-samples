//
//  KPCustomNotificationView.h
//  Kiip
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Kiip, Inc. All rights reserved.
//

#import <KiipSDK/KPNotificationView.h>
#import <KiipSDK/KPPoptart.h>
@interface KPCustomNotificationView : KPNotificationView
@property (strong, nonatomic) UILabel *notificationTitle;
@property (strong, nonatomic) UILabel *notificationMessage;
@property (strong, nonatomic) UIImageView *notificationIcon;

@end
