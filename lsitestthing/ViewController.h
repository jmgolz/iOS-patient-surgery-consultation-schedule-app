//
//  ViewController.h
//  lsitestthing
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIView *searchResultsView;
@property (strong, nonatomic) IBOutlet UIView *mainScreenView;

@property (strong, nonatomic) NSMutableArray *jsonobj;

- (IBAction)getApiData:(id)sender;

@end

