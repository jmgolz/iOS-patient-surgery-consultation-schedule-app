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
    [self getMapLocation];
    
    NSMutableString *seatsRemaining = [NSMutableString stringWithString:[self.selectedSeminar valueForKey:@"seats_avail"]];
    [seatsRemaining appendString:@" seats remaining"];
    
    self.seminarTtitle.text = [self.selectedSeminar valueForKey:@"host"];
    self.seatsRemaning.text = seatsRemaining;
    self.seminarBody.text = [self makeAddressForSubtitleTextLabel];
    [self makeDateStringsAndPopulateViews:self.selectedSeminar];
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

-(void)getMapLocation{
    self.addressForLookup = [NSMutableString stringWithString:[self.selectedSeminar valueForKey:@"address"]];
    [self.addressForLookup appendString:[NSString stringWithFormat:@" %@, ", [self.selectedSeminar valueForKey:@"city"]]];
    [self.addressForLookup appendString:[NSString stringWithFormat:@"%@, ", [self.selectedSeminar valueForKey:@"state"]]];
    [self.addressForLookup appendString:[NSString stringWithFormat:@"%@ ", [self.selectedSeminar valueForKey:@"zip"]]];
    [self.addressForLookup appendString:[NSString stringWithFormat:@"%@", [self.selectedSeminar valueForKey:@"country"]]];

    CLGeocoder *getGpsCoordsFromAddress = [[CLGeocoder alloc]init];
    
    [getGpsCoordsFromAddress geocodeAddressString:self.addressForLookup completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        self.seminarLocationOnMap = placemarks.firstObject;
        MKCoordinateRegion mapRegion = MKCoordinateRegionMakeWithDistance(self.seminarLocationOnMap.location.coordinate, 2200, 2200);
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        
        point.coordinate = self.seminarLocationOnMap.location.coordinate;
        point.title = [self.selectedSeminar valueForKey:@"host"];
        point.subtitle = self.addressForLookup;

        self.seminarMapDisplay.region = mapRegion;
        [self.seminarMapDisplay addAnnotation:point];
    }];
}

-(void)makeDateStringsAndPopulateViews:(NSDictionary *)seminarData{
    NSString *dateTimeString = [seminarData valueForKey:@"seminar_date"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateTimeString];
    
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [outputDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //Make date segments
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger day = [components day];
    
    NSDateFormatter *formattedMonth = [[NSDateFormatter alloc] init];
    [formattedMonth setDateFormat:@"MMM"];
    
    NSDateFormatter *formattedTime = [[NSDateFormatter alloc] init];
    [formattedTime setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formattedTime setTimeStyle:NSDateFormatterShortStyle];
    
    self.month.text = [formattedMonth stringFromDate:date];
    self.day.text = [NSString stringWithFormat:@"%li", (long)day];
    self.time.text = [formattedTime stringFromDate:date];
}

-(NSMutableString*)makeAddressForSubtitleTextLabel{
    NSMutableString *addressStringForSubtitle = [NSMutableString stringWithString:[self.selectedSeminar valueForKey:@"address"]];
    [addressStringForSubtitle appendString:[NSString stringWithFormat:@"\n%@, ", [self.selectedSeminar valueForKey:@"city"]]];
    [addressStringForSubtitle appendString:[NSString stringWithFormat:@"%@, ", [self.selectedSeminar valueForKey:@"state"]]];
    [addressStringForSubtitle appendString:[NSString stringWithFormat:@"%@", [self.selectedSeminar valueForKey:@"zip"]]];
    
    return addressStringForSubtitle;
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
