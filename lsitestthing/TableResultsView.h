//
//  TableResultsView.h
//  lsitestthing
//
//  Created by James Golz on 9/23/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSeminarCell.h"

@interface TableResultsView : UIViewController<UITableViewDelegate, UITableViewDataSource>
//@interface TableResultsView : UITableViewController<UITableViewDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *mainTable;

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet CustomSeminarCell *customCell;


@property (weak, nonatomic) NSMutableArray *jsonResults;
@property NSString *zipCode;
@property NSMutableArray *zipCodeResults;
@property NSDictionary *selectedSeminar;

@end
