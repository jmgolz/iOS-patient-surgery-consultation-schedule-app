//
//  SeminarDetailView.m
//  lsitestthing
//
//  Created by James Golz on 9/30/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "SeminarDetailView.h"

@interface SeminarDetailView ()

@end

@implementation SeminarDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cancelButton.enabled = NO;

//    self.seminarMapDisplay.region = [MKCoordinateRegionMake(self.seminarLocationOnMap.location.coordinate, [MKCoordinateSpanMake(self.seminarLocationOnMap.location.coordinate.latitude, self.seminarLocationOnMap.location.coordinate.longitude)])];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToSeminarView:(id)sender {
    [self performSegueWithIdentifier:@"returnToResultsView" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
