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
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *resultsRowCell;
//    //reuse ident for table cell: seminarResultRow
//    return resultsRowCell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
//}

@end
