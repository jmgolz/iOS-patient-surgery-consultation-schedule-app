//
//  ApiConnectionsHandler.m
//  lsitestthing
//
//  Created by James Golz on 10/1/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "ApiConnectionsHandler.h"

@protocol ApiConnectionsHandlerDelegate

@end

@implementation ApiConnectionsHandler

- (void)getApiSeminarData:(NSURLSession*)connectionHandler{
    NSMutableString *apiUrlEndpoint = [NSMutableString stringWithFormat:@"%@seminars.json?", apiUrlBase];
    NSURLRequest *apiConnectionRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:apiUrlEndpoint] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [connectionHandler dataTaskWithRequest:apiConnectionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError = nil;
        self.jsonSeminarDataFromApi = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    }];
}

- (void)getApiZipCodeData:(NSURLSession*)connectionHandler{
    NSMutableString *apiUrlEndpoint = [NSMutableString stringWithFormat:@"%@zip/radius.json?", apiUrlBase];
    NSURLRequest *apiConnectionRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:apiUrlEndpoint] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

    
    [connectionHandler dataTaskWithRequest:apiConnectionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError = nil;
        self.jsonZipcodeDataFromApi = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    }];
}

@end
