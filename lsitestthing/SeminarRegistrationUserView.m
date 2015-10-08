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
    //NSLog(@"data storage: %@", self.dataController.debugDescription);
    
    
    ///Test get data on form load...
    NSError *dataRequestError = nil;
    NSFetchRequest *dataStorageFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserFormData"];
    NSSortDescriptor *sortByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    [dataStorageFetchRequest setSortDescriptors:@[sortByLastName]];
    
    NSArray *results = [[self.dataController managedObjectContext] executeFetchRequest:dataStorageFetchRequest error:&dataRequestError];
    NSLog(@"Errors: %@\n%@", [dataRequestError localizedDescription], [dataRequestError userInfo]);
    
    UserFormDataStorageObject *resultsFromArray = [results objectAtIndex:0];

    NSLog(@"Data? %@", [resultsFromArray phoneFirstThree]);
    
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
    
    makeSaveDataObject.streetAddress = @"test streetAddress";
    makeSaveDataObject.address1 = @"test address1";
    makeSaveDataObject.address2 = @"test address2";
    makeSaveDataObject.city = @"test city";
    makeSaveDataObject.state = @"test state";
    makeSaveDataObject.zipCode = @"test zipCode";
    
    makeSaveDataObject.firstName = @"test firstName";
    makeSaveDataObject.lastName = @"test lastName";
    makeSaveDataObject.emailAddress = @"test emailAddress";
    makeSaveDataObject.timeZone = @"test timeZone";
    
    makeSaveDataObject.bestTimeToCall = @"test bestTimeToCall";
    makeSaveDataObject.areaCode = @"test areaCode";
    makeSaveDataObject.phoneFirstThree = @"test phoneFirstThree";
    makeSaveDataObject.phoneLastFour = @"test phoneLastFour";
    
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
}

- (IBAction)cancelUserRegistrationFormFill:(id)sender {
}

- (void)instantiateCoreDataStorageObject{
    self.dataController = [[RegistrationFormDataController alloc] init];
    [self setDataController:self.dataController];
    [[self fetchedResultsController] setDelegate:self];
    
    //NSFetchRequest *dataStorageFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserFormData"];
    
//        NSSortDescriptor *sortByLastName = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
//        [dataStorageFetchRequest setSortDescriptors:@[sortByLastName]];
    
    
    
    
    //    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:dataStorageFetchRequest managedObjectContext:[self.dataController managedObjectContext] sectionNameKeyPath:nil cacheName:nil]];
    //
    
    //
    
    //NSError *error = nil;
    //NSArray *results = [[self.dataController managedObjectContext] executeFetchRequest:dataStorageFetchRequest error:&error];
    
//    if (!results) {
//        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    } else {
//        NSLog(@"got data! %@", results.debugDescription);
//    }
    //    if (![[self fetchedResultsController] performFetch:&error]) {
    //        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
    //        abort();
    //    }
}

@end
