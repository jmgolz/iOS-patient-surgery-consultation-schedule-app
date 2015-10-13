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

-(void)viewDidAppear:(BOOL)animated{
    //NSLog(@"seminar id? after reappar %@", self.selectedSeminar.debugDescription);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self instantiateCoreDataStorageObject];
    
    self.statePicker.delegate = self;
    self.statePicker.dataSource = self;
    
    self.timeZonePicker.delegate = self;
    self.timeZonePicker.dataSource = self;
    
    self.bestTimeToCallPicker.delegate = self;
    self.bestTimeToCallPicker.dataSource = self;
    
    self.statesAbbrevAndFullNamesDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:0];
    
    self.timeZoneDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:1];
    
    self.bestTimeToCallDataSource = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"applicationReusableData" ofType:@"plist"]] objectAtIndex:2];
    
    NSLog(@"seminar id? %@", self.selectedSeminar.debugDescription);
    
    //NSLog(@"data storage: %@", self.dataController.debugDescription);
    
    
    ///Test get data on form load...
    NSError *dataRequestError = nil;
    NSFetchRequest *dataStorageFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserFormData"];
    NSSortDescriptor *sortByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    [dataStorageFetchRequest setSortDescriptors:@[sortByLastName]];
    
    NSArray *results = [[self.dataController managedObjectContext] executeFetchRequest:dataStorageFetchRequest error:&dataRequestError];
    NSLog(@"Errors: %@\n%@", [dataRequestError localizedDescription], [dataRequestError userInfo]);
    
    UserFormDataStorageObject *resultsFromArray = results.firstObject;

    NSLog(@"Data? %@", [resultsFromArray state]);
    
    [self populateUserRegistrationFieldsIfUserSavedData:resultsFromArray];
    
    //end test
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)saveUserRegistrationFormData:(id)sender {
    UserFormDataStorageObject *makeSaveDataObject = [NSEntityDescription insertNewObjectForEntityForName:@"UserFormData" inManagedObjectContext:[self.dataController managedObjectContext]];
    
    makeSaveDataObject.firstName = self.firstNameField.text;
    makeSaveDataObject.lastName = self.lastNameField.text;
    makeSaveDataObject.address1 = self.streetAddressField.text;
    makeSaveDataObject.address2 = self.secondAddressField.text;
    makeSaveDataObject.city = self.cityField.text;
    makeSaveDataObject.zipCode = self.zipcodeField.text;
    makeSaveDataObject.areaCode = self.areaCodeField.text;
    makeSaveDataObject.phoneFirstThree = self.phoneNumberFirstThreeDigitsField.text;
    makeSaveDataObject.phoneLastFour = self.phoneNumberLastFourDigitsField.text;
    makeSaveDataObject.emailAddress = self.emailAddressField.text;
    
    makeSaveDataObject.timeZone = self.timeZoneSelected;
    makeSaveDataObject.bestTimeToCall = self.bestTimeToCallSelected;
    makeSaveDataObject.state = self.stateSelected;
    
    NSError *saveError = nil;
    [[self.dataController managedObjectContext] insertObject:makeSaveDataObject];
    
    [[self.dataController managedObjectContext] save:&saveError];
    
    if(saveError != nil){
        NSLog(@"Error saving data: %@\n%@", [saveError localizedDescription], [saveError userInfo]);
    } else {
        NSError *dataRequestError = nil;
        NSFetchRequest *dataStorageFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserFormData"];
        NSSortDescriptor *sortByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
        [dataStorageFetchRequest setSortDescriptors:@[sortByLastName]];
        
        NSArray *results = [[self.dataController managedObjectContext] executeFetchRequest:dataStorageFetchRequest error:&dataRequestError];

        if (!results) {
            NSLog(@"Error fetching Employee objects: %@\n%@", [dataRequestError localizedDescription], [dataRequestError userInfo]);
            abort();
        } else {
            NSLog(@"got data! %@", results.debugDescription);
        }

    }
}

- (IBAction)clearUserRegistrationFormData:(id)sender {
//    NSError *dataRequestError = nil;
//    NSFetchRequest *dataStorageFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserFormData"];
//    NSSortDescriptor *sortByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
//    [dataStorageFetchRequest setSortDescriptors:@[sortByLastName]];
//    
//    NSArray *results = [[self.dataController managedObjectContext] executeFetchRequest:dataStorageFetchRequest error:&dataRequestError];
//    NSLog(@"Errors: %@\n%@", [dataRequestError localizedDescription], [dataRequestError userInfo]);
//    
//    UserFormDataStorageObject *resultsFromArray = [results objectAtIndex:0];
//    
//    NSLog(@"Data? %@", [resultsFromArray phoneFirstThree]);
//    
//    //DELETE!
//    [[self.dataController managedObjectContext] deleteObject:resultsFromArray];
    
    //end test
}

- (IBAction)cancelUserRegistrationFormFill:(id)sender {
}

- (void)instantiateCoreDataStorageObject{
    self.dataController = [[RegistrationFormDataController alloc] init];
    [self setDataController:self.dataController];
    [[self fetchedResultsController] setDelegate:self];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 0){
        self.stateSelected = [[self.statesAbbrevAndFullNamesDataSource objectAtIndex:row] objectForKey:@"stateFullName"];
    } else if (pickerView.tag == 1) {
        self.timeZoneSelected = [self.timeZoneDataSource objectAtIndex:row];
    } else if (pickerView.tag == 2) {
        self.bestTimeToCallSelected = [self.bestTimeToCallDataSource objectAtIndex:row];
    }
}



-(void)populateUserRegistrationFieldsIfUserSavedData:(UserFormDataStorageObject *)savedDataObject{
    NSArray *getAllViews = [[self view] subviews];

    for (UIView *viewController in getAllViews) {
        NSString *controllerType = NSStringFromClass([viewController class]);
        
        if ([controllerType isEqualToString:@"UITextField"]) {
            [viewController setValue:[savedDataObject valueForKey:[viewController accessibilityIdentifier]] forKey:@"text"];
        }
        
        if ([controllerType isEqualToString:@"UIPickerView"]) {
            NSUInteger indexOfItemSelectedByUser = -1;
            if(viewController.tag == 0){
                NSArray *findState = self.statesAbbrevAndFullNamesDataSource;
                for (NSDictionary *stateData in findState) {
                    if ([[stateData objectForKey:@"stateFullName"] isEqualToString:savedDataObject.state]) {
                        indexOfItemSelectedByUser = [findState indexOfObject:stateData];
                    }
                }
            } else if(viewController.tag == 1){
                 indexOfItemSelectedByUser = [self.timeZoneDataSource indexOfObject:savedDataObject.timeZone];
            } else if(viewController.tag == 2){
                indexOfItemSelectedByUser = [self.bestTimeToCallDataSource indexOfObject:savedDataObject.bestTimeToCall];
            }
            [(UIPickerView *)viewController selectRow:indexOfItemSelectedByUser inComponent:0 animated:NO];
        }
    }
}
@end
