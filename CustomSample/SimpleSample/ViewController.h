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
@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>{
    UIPickerView *pickerView;
    NSMutableArray *dataArray;
    NSString *notifType;
    KPPoptart *savedPoptart;
    KPCustomButton * redeemButton;
    NSString *momentID;
    IBOutlet UITextField *MomentField;
}

@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, strong) KPPoptart *savedPoptart;

@end

