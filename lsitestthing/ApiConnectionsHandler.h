//
//  ApiConnectionsHandler.h
//  lsitestthing
//
//  Created by James Golz on 10/1/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
static const NSString *apiUrlBase = @"http://api.laserspineinstitute.com/";

@interface ApiConnectionsHandler : NSObject

@property (strong, nonatomic) NSMutableArray *jsonDataFrom;
@property NSURLSession *apiInteractionSession;

- (NSData*)getApiSeminarData:(id)sender;
- (NSData*)getApiZipCodeData:(id)sender;


@end
