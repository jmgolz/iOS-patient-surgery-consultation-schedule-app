//
//  ViewController.m
//  lsitestthing
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "ViewController.h"
#import "TableResultsView.h"

@interface ViewController ()

@end

@implementation ViewController
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

-(void)viewWillAppear:(BOOL)animated{
    if (APP_DEBUG == YES) {
        NSString *getPlistPath = [[NSBundle mainBundle] pathForResource:@"testing" ofType:@"plist"];
        NSString *jsondataString = [[NSDictionary dictionaryWithContentsOfFile:getPlistPath] objectForKey:@"testSeminarsResponseJson"];
        
        NSData *jsonDataObj = [jsondataString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *jsonDecodeError = nil;
        self.jsonobj = [NSJSONSerialization JSONObjectWithData:jsonDataObj options:0 error:&jsonDecodeError];        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.apiInteractionSession = [NSURLSession sharedSession];
    self.locationManager = [[CLLocationManager alloc] init];
    self.zipCodeResults = [[NSMutableArray alloc] init];
    self.locationManager.delegate = self;
    
    self.apiConnectionHandler = [[ApiConnectionsHandler alloc] init];
    self.apiConnectionHandler.delegate = self;

}
- (IBAction)enableLocationServices:(id)sender {
    NSLog(@"clicked button");
    
    if( [self.toggleUseLocation isOn] == YES) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager stopUpdatingLocation];
    }
    
}

-(void)apiInteractionComplete:(NSMutableArray*)returnedData error:(NSError*)error apiEndpointUsed:(NSString*)apiEndpoint{
    
    if ([apiEndpoint isEqualToString:@"seminars"] == YES) {
        self.jsonobj = returnedData;
        [self performSegueWithIdentifier:@"test" sender:nil];
    } else if ([apiEndpoint isEqualToString:@"zipcode"]){
        self.zipCodeResults = returnedData;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getApiData:(id)sender {
    if (APP_DEBUG == YES) {
        [self performSegueWithIdentifier:@"test" sender:nil];
    } else {
        [self.apiConnectionHandler getApiSeminarData:self.apiInteractionSession];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TableResultsView *instanceDestinationControllerResultsView = segue.destinationViewController;
    instanceDestinationControllerResultsView.jsonResults = self.jsonobj;
    instanceDestinationControllerResultsView.zipCode = self.zipCode;
    instanceDestinationControllerResultsView.zipCodeResults = self.zipCodeResults;
}


//CoreLocation services delegate function implementations
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@", error);
    
    UIAlertController *errorDialog = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Could not get location" preferredStyle:UIAlertControllerStyleAlert];
    [errorDialog addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:errorDialog animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *currentLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        self.zipCode = [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"ZIP"];
        [self.apiConnectionHandler getApiZipCodeData:self.apiInteractionSession zipCode:self.zipCode];
        [self.locationManager stopUpdatingLocation];
    }];
}
@end
