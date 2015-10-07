//
//  SeminarRegistrationMedicalView.m
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "SeminarRegistrationMedicalView.h"

@interface SeminarRegistrationMedicalView ()

@end

@implementation SeminarRegistrationMedicalView

-(void)viewWillAppear:(BOOL)animated{
    self.howDidYouHearAboutUsDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:5];
    self.insuranceCompanyDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.insuranceCompanyPicker.delegate = self;
    self.insuranceCompanyPicker.dataSource = self;
    
    self.howDidYouHearAboutUsPicker.delegate = self;
    self.howDidYouHearAboutUsPicker.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        return [self.insuranceCompanyDataSource objectAtIndex:row];
    } else {
        return [self.howDidYouHearAboutUsDataSource objectAtIndex:row];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        return self.insuranceCompanyDataSource.count;
    } else  {
        return self.howDidYouHearAboutUsDataSource.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveDataButtonPressed:(id)sender {
}

- (IBAction)clearFormButtonPressed:(id)sender {
}

- (IBAction)cancelFormButtonPressed:(id)sender {
}
- (IBAction)insuranceTypeSegmentedButtonPressed:(id)sender {
}

- (IBAction)patientIsBringingMriSegmentedButtonPressed:(id)sender {
}

- (IBAction)howManyInPatientPartyStepperButton:(id)sender {
}
@end
