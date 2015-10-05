//
//  SeminarRegistrationUserView.m
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "SeminarRegistrationUserView.h"

@interface SeminarRegistrationUserView ()

@end

@implementation SeminarRegistrationUserView

-(SeminarRegistrationUserView *)viewControllerAtIndex:(NSUInteger)index{
    return self;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    return self;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"seminarRegistrationUser"];
//    self.pageViewController.dataSource = self;
//    
//    NSArray *viewControllersArray = @[self];
//    [self.pageViewController setViewControllers:viewControllersArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    [self addChildViewController:self.pageViewController];
//    [self.view addSubview:self.pageViewController.view];
//    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
//    return 2;
//}
//
//-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
//    return 0;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
