//
//  ApiConnectionsHandler.m
//  lsitestthing
//
//  Created by James Golz on 10/1/15.
//  Copyright © 2015 Sharks with Laser Spines. All rights reserved.
//

#import "ApiConnectionsHandler.h"

@implementation ApiConnectionsHandler

- (void)getApiSeminarData:(NSURLSession*)connectionHandler{
    NSMutableString *apiUrlEndpoint = [NSMutableString stringWithFormat:@"%@redacted because NDAs", apiUrlBase];
    NSURLRequest *apiConnectionRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:apiUrlEndpoint] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [[connectionHandler dataTaskWithRequest:apiConnectionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError = nil;
        NSMutableArray *dataFromApi = nil;

        dataFromApi = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (self.delegate && [self.delegate respondsToSelector:@selector(apiInteractionSession)]) {
            [self.delegate apiInteractionComplete:dataFromApi error:error apiEndpointUsed:@"seminars"];
        }
    }] resume];
}

- (void)getApiZipCodeData:(NSURLSession*)connectionHandler zipCode:(NSString*)zipCode{
    NSMutableString *apiUrlEndpoint = [NSMutableString stringWithFormat:@"%@redacted because NDAs?", apiUrlBase];
    [apiUrlEndpoint appendString:[NSString stringWithFormat:@"redacted because NDAs%@", zipCode]];
    [apiUrlEndpoint appendString:@"redacted because NDAs"];
    
    
    NSURLRequest *apiConnectionRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:apiUrlEndpoint] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

    
    [[connectionHandler dataTaskWithRequest:apiConnectionRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError = nil;
        NSMutableArray *dataFromApi = nil;

        dataFromApi = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (self.delegate && [self.delegate respondsToSelector:@selector(apiInteractionSession)]) {
            [self.delegate apiInteractionComplete:dataFromApi error:error apiEndpointUsed:@"zipcode"];
        }

    }] resume];
}
-(void)apiInteractionComplete:(NSMutableArray*)returnedData error:(NSError*)error apiEndpointUsed:(NSString*)apiEndpoint{}
@end
