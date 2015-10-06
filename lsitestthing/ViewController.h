//
//  ViewController.h
//  lsitestthing
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ApiConnectionsHandler.h"

static const BOOL APP_DEBUG = NO;

@interface ViewController : UIViewController<CLLocationManagerDelegate, ApiConnectionsHandlerDelegate>
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIView *searchResultsView;
@property (strong, nonatomic) IBOutlet UIView *mainScreenView;

@property (strong, nonatomic) NSMutableArray *jsonobj;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UISwitch *toggleUseLocation;
@property NSURLSession *apiInteractionSession;

@property ApiConnectionsHandler *apiConnectionHandler;

@property NSString *zipCode;
@property (strong, nonatomic) NSMutableArray *zipCodeResults;

- (IBAction)getApiData:(id)sender;
-(void)apiInteractionComplete:(NSMutableArray*)returnedData error:(NSError*)error apiEndpointUsed:(NSString*)apiEndpoint;

@end

