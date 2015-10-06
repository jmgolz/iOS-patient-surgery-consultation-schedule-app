//
//  SeminarRegistrationUserView.h
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeminarRegistrationUserView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property NSUInteger pageIndex;
@property (strong, nonatomic) UIPageViewController *pageViewController;


//Selection pickers
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *timeZonePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *bestTimeToCallPicker;

//Text fields for main user info
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@property (weak, nonatomic) IBOutlet UITextField *streetAddressField;
@property (weak, nonatomic) IBOutlet UITextField *secondAddressField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeField;

@property (weak, nonatomic) IBOutlet UITextField *areaCodeField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberFirstThreeDigitsField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLastFourDigitsField;

@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;

//Save, clear, cancel buttons
@property (weak, nonatomic) IBOutlet UIButton *saveDataButton;
@property (weak, nonatomic) IBOutlet UIButton *clearFormButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


//Data sources
@property NSArray *statesAbbrevAndFullNamesDataSource;
@property NSArray *timeZoneDataSource;
@property NSArray *bestTimeToCallDataSource;

@end
