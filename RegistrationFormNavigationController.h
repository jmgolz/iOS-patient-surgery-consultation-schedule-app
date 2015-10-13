//
//  RegistrationFormNavigationController.h
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeminarRegistrationMedicalView.h"
#import "SeminarRegistrationUserView.h"

@interface RegistrationFormNavigationController : UITabBarController<UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *registrationFormControllerTabBar;
@property NSDictionary *selectedSeminar;



@end
