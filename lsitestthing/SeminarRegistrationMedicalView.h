//
//  SeminarRegistrationMedicalView.h
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeminarRegistrationMedicalView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

//Picker outlets
@property (weak, nonatomic) IBOutlet UIPickerView *insuranceCompanyPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *howDidYouHearAboutUsPicker;

//Buttons - form inputs
@property (weak, nonatomic) IBOutlet UISegmentedControl *insuranceTypeSegmentedButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *patientIsBringingMriSegmentedButton;
@property (weak, nonatomic) IBOutlet UIStepper *howManyInPatientPartyStepperButton;

//Buttons - form actions
@property (weak, nonatomic) IBOutlet UIButton *saveFormDataButton;
@property (weak, nonatomic) IBOutlet UIButton *clearFormButton;
@property (weak, nonatomic) IBOutlet UIButton *formCancelButton;

//Form action control interactions
- (IBAction)saveDataButtonPressed:(id)sender;
- (IBAction)clearFormButtonPressed:(id)sender;
- (IBAction)cancelFormButtonPressed:(id)sender;

//Form input control interactions
- (IBAction)insuranceTypeSegmentedButtonPressed:(id)sender;
- (IBAction)patientIsBringingMriSegmentedButtonPressed:(id)sender;
- (IBAction)howManyInPatientPartyStepperButton:(id)sender;

//Data sources
@property NSArray *insuranceCompanyDataSource;
@property NSArray *howDidYouHearAboutUsDataSource;

@end
