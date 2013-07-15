//
//  AppDelegate.h
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>
#import "KPCustomNotificationView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,KiipDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) KPCustomNotificationView *customNotificationView;
@property (strong, nonatomic) UILabel *notificationTitle;
@property (strong, nonatomic) UILabel *notificationMessage;
@property (strong, nonatomic) UIImageView *notificationIcon;

-(void)toggleNotification:(BOOL)enabled;
-(void)addInfo:(KPPoptart *)poptart;
-(void)addInfo:(KPPoptart *)poptart toButton:(UIButton*)button;
@end
