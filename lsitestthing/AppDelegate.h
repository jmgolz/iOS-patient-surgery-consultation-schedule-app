//
//  AppDelegate.h
//  lsitestthing
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RegistrationFormDataController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property RegistrationFormDataController *dataController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

