//
//  TableResultsView.h
//  lsitestthing
//
//  Created by James Golz on 9/23/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSeminarCell.h"
#import "ApiConnectionsHandler.h"

@interface TableResultsView : UIViewController<UITableViewDelegate, UITableViewDataSource, ApiConnectionsHandlerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet CustomSeminarCell *customCell;

@property NSURLSession *apiInteractionSession;
@property ApiConnectionsHandler *apiConnectionHandler;

@property (weak, nonatomic) NSMutableArray *jsonResults;
@property NSString *zipCode;
@property NSMutableArray *zipCodeResults;
@property NSDictionary *selectedSeminar;

@end
