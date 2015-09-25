//
//  ViewController.h
//  lsitestthing
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIView *searchResultsView;
@property (strong, nonatomic) IBOutlet UIView *mainScreenView;

@property (strong, nonatomic) NSMutableArray *jsonobj;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UISwitch *toggleUseLocation;
@property NSURLSession *apiInteractionSession;

@property NSString *zipCode;
@property (strong, nonatomic) NSMutableArray *zipCodeResults;

- (IBAction)getApiData:(id)sender;

@end

