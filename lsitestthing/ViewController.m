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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.apiInteractionSession = [NSURLSession sharedSession];
    self.locationManager = [[CLLocationManager alloc] init];
    self.zipCodeResults = [[NSMutableArray alloc] init];
    self.locationManager.delegate = self;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getApiData:(id)sender {
    NSString *apiUrlBase = @"http://api.laserspineinstitute.com/seminars.json";
    
    [[self.apiInteractionSession
      dataTaskWithURL:[NSURL URLWithString:apiUrlBase]
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          NSError *jsonError = nil;
          self.jsonobj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
          NSLog(@"Got API response: %@", [[self.jsonobj objectAtIndex:0] valueForKey:@"host"]);
          [self performSegueWithIdentifier:@"test" sender:sender];
      }] resume];
    
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
    NSMutableString *zipCodeURL = [NSMutableString stringWithString:@"http://api.laserspineinstitute.com/zip/radius.json?"];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        self.zipCode = [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"ZIP"];
        
        [zipCodeURL appendString:[NSString stringWithFormat:@"zip=%@", self.zipCode]];
        [zipCodeURL appendString:@"&radius=100&fields=ZipCode"];
        
        [[self.apiInteractionSession
          dataTaskWithURL:[NSURL URLWithString:zipCodeURL]
          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              NSError *jsonGetZipError = nil;
              NSMutableArray *tempZipCodeResults = [[NSMutableArray alloc]init];
              
              tempZipCodeResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonGetZipError];
              
              for ( NSDictionary *zipCode in tempZipCodeResults) {
                  [self.zipCodeResults addObject:[zipCode objectForKey:@"ZipCode"]];
              }
              //NSLog(@"Got ZIP CODE API response: %@", [self.zipCodeResults debugDescription]);
              
          }] resume];
        [self.locationManager stopUpdatingLocation];
    }];
}
@end
