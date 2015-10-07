//
//  RegistrationFormDataController.m
//  lsitestthing
//
//  Created by James Golz on 10/7/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "RegistrationFormDataController.h"

@implementation RegistrationFormDataController

-(id)init{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self initializeCoreData];
    return self;
}

-(void)initializeCoreData{
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"seminarRegistrationDataStorage" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsUrl = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeUrl = [documentsUrl URLByAppendingPathComponent:@"seminarRegistrationDataStorage.sqlite"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@",error.localizedDescription, error.userInfo);
    });
}
@end
