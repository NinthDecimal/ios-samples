//
//  ViewController.m
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import "ViewController.h"
#import "KPCustomNotificationView.h"


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
    
    //setting frame, image, and action of Integrated Notification 
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.redeemButton = [[KPCustomButton alloc] initWithFrame:CGRectMake(20, 200, 278, 50)];
    }
    else {
        self.redeemButton = [[KPCustomButton alloc] initWithFrame:CGRectMake(245, 480, 278, 50)];
    }
    
    [self.redeemButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [self.redeemButton addTarget:self action:@selector(integratedTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)callMoment:(id)sender {
    //checking for type of moment
    if ([self.notifType isEqualToString:kNotificationDefault])
        [self normal];
    else if ([self.notifType isEqualToString:kNotificationCustom])
        [self customBanner];
    else
        [self customButton];
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

-(void)normal {
    //method with block for completion handler; if error, error message is show. Otherwise, a poptart is shown
    [[Kiip sharedInstance] saveMoment:self.momentField.text withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
        if (error) {
            [self didReceiveError:error];
        }
        else{
            [poptart show];
        }
    }];
}

-(void)customBanner {
    //method with block for completion handler; if error, error message is show. Otherwise, a poptart is shown
    [[Kiip sharedInstance] saveMoment:self.momentField.text withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
        if (error) {
            [self didReceiveError:error];
        }
        else{
            [poptart show];
        }
    }];
}

-(void)customButton {
    //method with block for completion handler; if error, error message is show. Otherwise, a poptart is shown
    [[Kiip sharedInstance] saveMoment:self.momentField.text withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
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
            [self.view addSubview:self.redeemButton];
        }
    }];
}

//returns error message
- (void)didReceiveError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

//hides keyboard when user hits "return"
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//hides keyboard when user touches anywhere outside the keyboard 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//removes button after tapped
- (void)integratedTouchUpInside:(id)sender {
    [self.savedPoptart show];
    [self.redeemButton removeFromSuperview];
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

#define KEYBOARD_HEIGHT_PORTRAIT 216;
#define KEYBOARD_HEIGHT_LANDSCAPE 162;

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

