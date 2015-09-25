//
//  TableResultsView.m
//  lsitestthing
//
//  Created by James Golz on 9/23/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "TableResultsView.h"

@implementation TableResultsView

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"KEPT API response: %@", [self.jsonResults debugDescription]);
    NSLog(@"KEPT ZIP: %@", self.zipCode);
    NSLog(@"KEPT ZIP CODE API response: %@", [self.zipCodeResults debugDescription]);
//    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
//    
//    if(self.zipCodeResults != nil){
//        for (NSDictionary *seminarItem in self.jsonResults) {
//            if ([self.zipCodeResults containsObject:[seminarItem objectForKey:@"zip"]] == YES) {
//                NSLog(@"seminar: %@", [seminarItem objectForKey:@"zip"]);
//                [tempArray addObject:seminarItem];
//            }
//        }
//        NSLog(@"temp seminar: %@", [tempArray debugDescription]);
//        self.jsonResults = nil;
//        self.jsonResults = tempArray;
//    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultsRowCell = [tableView dequeueReusableCellWithIdentifier:@"seminarResultRow"];
    
    NSMutableString *titleText = [NSMutableString stringWithString:[[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"host"]];
    [titleText appendString:[NSString stringWithFormat:@" - %@", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"city"]]];
    [titleText appendString:[NSString stringWithFormat:@", %@", [[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"state"]]];
    
    NSMutableString *subtitleText = [NSMutableString stringWithString:[[self.jsonResults objectAtIndex:indexPath.row] valueForKey:@"address"]];

    //reuse ident for table cell: seminarResultRow
    [[resultsRowCell detailTextLabel] setText:subtitleText];
    [[resultsRowCell textLabel] setText:titleText];
    return resultsRowCell;
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


    
    UIAlertController *seminarDescription = [UIAlertController alertControllerWithTitle:@"Seminar Details" message:bodyText preferredStyle:UIAlertControllerStyleAlert];
    [seminarDescription addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:seminarDescription animated:YES completion:nil];
}


@end
