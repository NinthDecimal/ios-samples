//
//  ViewController.m
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import "ViewController.h"
#import "KPCustomNotificationView.h"

#define KEYBOARD_HEIGHT_PORTRAIT 216
#define KEYBOARD_HEIGHT_LANDSCAPE 162
#define ANIMATION_DURATION 0.3 // 300 ms

//types of notifications 
NSString *const kNotificationDefault = @"Default Notification";
NSString *const kNotificationCustom = @"Custom Notification";
NSString *const kNotificationIntegrated = @"Integrated Notification";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.momentField setDelegate:self];
    
    //setting the default notification type (what appears when the app is first opened up)
    self.notifType = kNotificationDefault;
    self.dataArray = @[
                  kNotificationDefault,
                  kNotificationCustom,
                  kNotificationIntegrated
                  ];
    
    //creating and adding picker view to mainview
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    self.redeemButton.alpha = 0.0f;
    [self.redeemButton setHidden:YES];
}

- (IBAction)callMoment:(id)sender {
    void (^handler)(KPPoptart *, NSError *);
    
    if (![self.notifType isEqualToString:kNotificationIntegrated]) {
        // Default handler
        handler = ^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self didReceiveError:error];
            }
            else{
                [poptart show];
            }
        };
    } else {
        // Integrated handler
        handler = ^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self didReceiveError:error];
            }
            if (poptart) {
                self.savedPoptart = poptart;
                //sending poptart data to KPCusomButton
                [self.redeemButton setPoptart:poptart];
                //removing Notification (this method uses a button instead)
                [poptart setNotification:nil];
                //adding button to the view
                [self.redeemButton setHidden:NO];
                [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                    self.redeemButton.alpha = 1.0;
                }];
            }
        };
    }
    
    [[Kiip sharedInstance] saveMoment:self.momentField.text withCompletionHandler:handler];
}

//setting up pickerview
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if([self.dataArray objectAtIndex: row]!=nil) {
        self.notifType = [self.dataArray objectAtIndex: row];
    }
    //turning on custom notification if the notification type is custom notification 
    [((AppDelegate *)[UIApplication sharedApplication].delegate) toggleNotification:[self.notifType isEqualToString:kNotificationCustom]];
}

//returns error message
- (void)didReceiveError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

//hides keyboard when user hits "return"
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//hides keyboard when user touches anywhere outside the keyboard 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//removes button after tapped
- (IBAction)integratedTouchUpInside:(id)sender {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.redeemButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.redeemButton setHidden:YES];
    }];
    [self.savedPoptart show];
}

//setting up pickerview
- (UIView *)pickerView:(UIPickerView *)pickerView1 viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *rowItem = [self.dataArray objectAtIndex: row];
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView1 bounds].size.width, 44.0f)];
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    [lblRow setTextColor: [UIColor blackColor]];
    [lblRow setText:rowItem];
    [lblRow setBackgroundColor:[UIColor clearColor]];
    return lblRow;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGRect frame = self.pickerView.frame;
    float screenHeight;
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        screenHeight = self.view.frame.size.height;
        frame.size.height = KEYBOARD_HEIGHT_PORTRAIT;
        frame.origin.y = screenHeight - KEYBOARD_HEIGHT_PORTRAIT;
    } else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        screenHeight = self.view.frame.size.height;
        frame.size.height = KEYBOARD_HEIGHT_LANDSCAPE;
        frame.origin.y = screenHeight - KEYBOARD_HEIGHT_LANDSCAPE;
    }
    self.pickerView.frame = frame;
}

@end

