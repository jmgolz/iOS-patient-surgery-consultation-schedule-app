//
//  RegistrationFormDataController.h
//  lsitestthing
//
//  Created by James Golz on 10/7/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RegistrationFormDataController : NSObject
@property NSManagedObjectContext *managedObjectContext;
-(void)initializeCoreData;
@end
