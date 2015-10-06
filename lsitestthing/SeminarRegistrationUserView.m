//
//  SeminarRegistrationUserView.m
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "SeminarRegistrationUserView.h"

@interface SeminarRegistrationUserView ()

@end

@implementation SeminarRegistrationUserView

-(SeminarRegistrationUserView *)viewControllerAtIndex:(NSUInteger)index{
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.statePicker.delegate = self;
    self.statePicker.dataSource = self;
    
    self.timeZonePicker.delegate = self;
    self.timeZonePicker.dataSource = self;
    
    self.bestTimeToCallPicker.delegate = self;
    self.bestTimeToCallPicker.dataSource = self;
    
    self.statesAbbrevAndFullNamesDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:0];
    
    self.timeZoneDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:1];
    
    self.bestTimeToCallDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:2];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        return [[self.statesAbbrevAndFullNamesDataSource objectAtIndex:row] objectForKey:@"stateFullName"];
    } else if(pickerView.tag == 1){
        return [self.timeZoneDataSource objectAtIndex:row];
    } else {
        return [self.bestTimeToCallDataSource objectAtIndex:row];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 0){
        return self.statesAbbrevAndFullNamesDataSource.count;
    } else if(pickerView.tag == 1){
        return self.timeZoneDataSource.count;
    } else {
        return self.bestTimeToCallDataSource.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
