//
//  userFormDataStorageObject.h
//  lsitestthing
//
//  Created by James Golz on 10/8/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UserFormDataStorageObject : NSManagedObject

@property NSString *streetAddress;
@property NSString *address1;
@property NSString *address2;
@property NSString *city;
@property NSString *state;
@property NSString *zipCode;

@property NSString *firstName;
@property NSString *lastName;
@property NSString *emailAddress;
@property NSString *timeZone;

@property NSString *bestTimeToCall;
@property NSString *areaCode;
@property NSString *phoneFirstThree;
@property NSString *phoneLastFour;

@end