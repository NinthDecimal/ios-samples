//
//  ViewController.h
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>
#import "AppDelegate.h"
#import "KPCustomButton.h"
@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSString *notifType;
@property (nonatomic, retain) KPPoptart *savedPoptart;
@property (nonatomic, retain) KPCustomButton * redeemButton;
@property (nonatomic, retain) NSString *momentID;
@property (nonatomic, retain) IBOutlet UITextField *MomentField;

@end

