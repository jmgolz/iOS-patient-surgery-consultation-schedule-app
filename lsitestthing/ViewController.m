//
//  ViewController.m
//  lsitestthing
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeftGestureHandler:(id)sender {
    NSLog(@"Swiped");
    
}

- (IBAction)getApiData:(id)sender {
    //reuse ident for table cell: seminarResultRow
    
    NSLog(@"Get API button fired");
    NSString *apiUrlBase = @"http://api.laserspineinstitute.com/seminars.json";

    NSURLSession *apiInteractionSession = [NSURLSession sharedSession];
    [[apiInteractionSession
      dataTaskWithURL:[NSURL URLWithString:apiUrlBase]
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
           NSError *jsonError = nil;
           self.jsonobj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

            //NSLog(@"Got API response: %@", [self.jsonobj valueAtIndex:]);
          NSLog(@"Got API response: %@", [self.jsonobj objectAtIndex:0]);
          
      }] resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultsRowCell = [tableView dequeueReusableCellWithIdentifier:@"seminarResultRow"];
    
    
    
    return resultsRowCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.jsonobj count];
}

@end
