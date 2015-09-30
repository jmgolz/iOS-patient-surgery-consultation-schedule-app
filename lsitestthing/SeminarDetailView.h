//
//  SeminarDetailView.h
//  lsitestthing
//
//  Created by James Golz on 9/30/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface SeminarDetailView : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *seminarMapDisplay;
@property NSDictionary *selectedSeminar;
@property CLPlacemark *seminarLocationOnMap;

@property (weak, nonatomic) IBOutlet UILabel *seminarTtitle;
@property (weak, nonatomic) IBOutlet UILabel *seminarBody;
@property (weak, nonatomic) IBOutlet UILabel *seatsRemaning;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitRegistrationButton;
@property (weak, nonatomic) IBOutlet UIButton *fillOutSeminarRegistrationButton;


@end
