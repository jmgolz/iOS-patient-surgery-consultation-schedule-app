//
//  SeminarRegistrationUserView.h
//  lsitestthing
//
//  Created by James Golz on 10/5/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>


//@interface SeminarRegistrationUserView : UIViewController<UIPageViewControllerDataSource>
@interface SeminarRegistrationUserView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property NSUInteger pageIndex;
@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property NSArray *statesListAbbrev;
@property NSArray *statesListFullName;

-(void)makeStatesList;
@end
