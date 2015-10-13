//
//  RegistrationFormNavigationController.m
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "RegistrationFormNavigationController.h"

@interface RegistrationFormNavigationController ()

@end

@implementation RegistrationFormNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    NSArray *viewControllers = [self viewControllers];
    for (UIViewController *vc in viewControllers) {
        [vc setValue:self.selectedSeminar forKey:@"selectedSeminar"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //dynamically set the selected seminar val?
    //[viewController setValue:self.selectedSeminar forKey:@"selectedSeminar"];
    NSLog(@"View controller is: %@", [viewController debugDescription]);
    NSLog(@"View seminar is: %@", [viewController valueForKey:@"selectedSeminar"]);
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
