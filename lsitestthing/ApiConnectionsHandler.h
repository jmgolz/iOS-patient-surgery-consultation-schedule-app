//
//  ApiConnectionsHandler.h
//  lsitestthing
//
//  Created by James Golz on 10/1/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
static const NSString *apiUrlBase = @"http://redacted because work privacy and stuff/";
static const NSString *seminarsEndpointURLFragment = @"SAME";
static const NSString *zipcodeEndpointURLFragment = @"SAME!";

@protocol ApiConnectionsHandlerDelegate;

@interface ApiConnectionsHandler : NSObject
@property (weak, nonatomic) id<ApiConnectionsHandlerDelegate> delegate;
@property NSURLSession *apiInteractionSession;

- (void)getApiSeminarData:(NSURLSession*)connectionHandler;
- (void)getApiZipCodeData:(NSURLSession*)connectionHandler zipCode:(NSString*)zipCode;
@end

@protocol ApiConnectionsHandlerDelegate <NSObject>
@optional
-(void)apiInteractionComplete:(NSMutableArray*)returnedData error:(NSError*)error apiEndpointUsed:(NSString*)apiEndpoint;
@end
