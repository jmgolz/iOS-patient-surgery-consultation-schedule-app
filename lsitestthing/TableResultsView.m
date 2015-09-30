//
//  TableResultsView.m
//  lsitestthing
//
//  Created by James Golz on 9/23/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "TableResultsView.h"
#import "SeminarDetailView.h"

@implementation TableResultsView

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"KEPT API response: %@", [self.jsonResults debugDescription]);
    NSLog(@"KEPT ZIP: %@", self.zipCode);
    NSLog(@"KEPT ZIP CODE API response: %@", [self.zipCodeResults debugDescription]);

    if ([self.zipCodeResults isEqual:nil] == NO) {
        
    }
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.customCell = [tableView dequeueReusableCellWithIdentifier:@"seminarResultRow"];
    
    NSMutableString *titleText = [NSMutableString stringWithString:[[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"host"]];
    
    [titleText appendString:@" Seminar"];
    
    NSMutableString *subtitleText = [NSMutableString stringWithString:[[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"address"]];
    [subtitleText appendString:[NSString stringWithFormat:@"\n%@", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"city"]]];
    [subtitleText appendString:[NSString stringWithFormat:@", %@", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"state"]]];
    [subtitleText appendString:[NSString stringWithFormat:@" %@", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"zip"]]];
    
    NSString *dateTimeString = [NSString stringWithFormat:@"%@", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"seminar_date"]];
    
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

    self.customCell.month.text = [formattedMonth stringFromDate:date];
    self.customCell.day.text = [NSString stringWithFormat:@"%li", (long)day];
    self.customCell.time.text = [formattedTime stringFromDate:date];
    
    
    self.customCell.seminarTtitle.text  = titleText;
    self.customCell.seminarBody.text    = subtitleText;
    self.customCell.seatsRemaning.text  = [NSString stringWithFormat:@"%@ Seats Remaining", [[self.jsonResults objectAtIndex:indexPath.row]valueForKey:@"seats_avail"]];
    
    return self.customCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.jsonResults count];
}

- (IBAction)handleSwipe:(id)sender {
    NSLog(@"SWIPED");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *bodyText = [NSMutableString stringWithString:[[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"host"]];
    
    [bodyText appendString:[NSString stringWithFormat:@"\n\n%@\n",       [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"seminar_date"]]];
    [bodyText appendString:[NSString stringWithFormat:@"%@\n", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"building"]]];
    [bodyText appendString:[NSString stringWithFormat:@"%@\n",           [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"address"]]];
    
    if ( [[[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"address2"] isEqual:@"<null>"] == YES ) {
       [bodyText appendString:[NSString stringWithFormat:@"%@\n", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"address2"]]];
    }
    
    [bodyText appendString:[NSString stringWithFormat:@"%@, ", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"city"]]];
    [bodyText appendString:[NSString stringWithFormat:@"%@ ",  [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"state"]]];
    [bodyText appendString:[NSString stringWithFormat:@"%@",   [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"zip"]]];

    self.selectedSeminar = [self.jsonResults objectAtIndex:indexPath.row];
    
    UIAlertController *seminarDescription = [UIAlertController alertControllerWithTitle:@"Seminar Details" message:bodyText preferredStyle:UIAlertControllerStyleActionSheet];
    [seminarDescription addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [seminarDescription addAction:[UIAlertAction actionWithTitle:@"Register for this seminar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [self performSegueWithIdentifier:@"moveToSeminarDetailView" sender:nil];
    }]];
    [self presentViewController:seminarDescription animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    SeminarDetailView *instanceDestinationControllerResultsView = segue.destinationViewController;
    instanceDestinationControllerResultsView.selectedSeminar = self.selectedSeminar;
    
    NSMutableString *addressForLookup = [NSMutableString stringWithString:[self.selectedSeminar valueForKey:@"address"]];
    [addressForLookup appendString:[NSString stringWithFormat:@"%@, ", [self.selectedSeminar valueForKey:@"city"]]];
    
    [addressForLookup appendString:[NSString stringWithFormat:@"%@, ", [self.selectedSeminar valueForKey:@"state"]]];
    
    [addressForLookup appendString:[NSString stringWithFormat:@"%@ ", [self.selectedSeminar valueForKey:@"zip"]]];

    [addressForLookup appendString:[NSString stringWithFormat:@"%@, ", [self.selectedSeminar valueForKey:@"country"]]];
                                  
    CLGeocoder *getGpsCoordsFromAddress = [[CLGeocoder alloc]init];
    
    
    [getGpsCoordsFromAddress geocodeAddressString:addressForLookup completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"Got coords? %@", placemarks.firstObject.debugDescription);
        instanceDestinationControllerResultsView.seminarLocationOnMap = placemarks.firstObject;
    }];
    
    
}
@end