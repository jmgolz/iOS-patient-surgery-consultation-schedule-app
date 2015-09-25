//
//  CustomSeminarCell.h
//  lsitestthing
//
//  Created by James Golz on 9/25/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSeminarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainDateRect;
@property (weak, nonatomic) IBOutlet UILabel *seminarTtitle;
@property (weak, nonatomic) IBOutlet UILabel *seminarBody;
@property (weak, nonatomic) IBOutlet UILabel *seatsRemaning;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
