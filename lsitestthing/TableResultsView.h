//
//  TableResultsView.h
//  lsitestthing
//
//  Created by James Golz on 9/23/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableResultsView : UITableViewController<UITableViewDelegate, UITableViewDataSource>
//@interface TableResultsView : UITableViewController<UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTable;

@property (weak, nonatomic) NSMutableArray *jsonResults;

@end
