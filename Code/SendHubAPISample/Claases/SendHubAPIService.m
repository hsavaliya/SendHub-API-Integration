//
//  SendHubAPIService.m
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import "SendHubAPIService.h"
#import  "SenfHubAPIConstants.h"
#import "Contacts.h"

@implementation SendHubAPIService

//Get Method - to get contacts
-(void)collectContactsByFilter {
    //set URL
    NSString *urlString = [NSString stringWithFormat:@"%@username=%@&api_key=%@",
                           API_CONTACTURL,
                           USERNAME,
                           API_KEY
                           ];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    // Create url connection and fire request
    if (conn) {
        self.urlRespondData = [NSMutableData data];
    }
}

//POST Method - to send message
-(void)sendMessage:(NSString *)contact andText:(NSString *)message; {
    
    //set URL
    NSString *urlString = [NSString stringWithFormat:@"%@username=%@&api_key=%@",
                           API_SENDMESSAGE,
                           USERNAME,
                           API_KEY
                           ];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"contacts\":[\"%@\"],\"text\":\"%@\"}",contact,message];
    NSData *requestBodyData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        self.urlRespondData = [NSMutableData data];
    }
}
#pragma mark connection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.urlRespondData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    // NSString* newStr = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    [self.urlRespondData appendData:d];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:@"Failed to connect to server"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *e = nil;
    
    NSDictionary *resultResponseDict = [NSJSONSerialization JSONObjectWithData:self.urlRespondData
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&e];
    
    if (resultResponseDict && [resultResponseDict count] > 0) {
        
        //call delegate method
        [self.delegate loadResultWithDataDict:resultResponseDict];
        
    }
    else
    {
        //alert with no data found
    }
    
}

- (void)connectionDidFinishLoading123:(NSURLConnection *)connection {
    NSError *e = nil;
    
    NSDictionary *resultResponseDict = [NSJSONSerialization JSONObjectWithData:self.urlRespondData
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&e];
    //remove previous content from array result
    if (self.resultArray && [self.resultArray count] > 0) {
        [self.resultArray removeAllObjects];
    }
    //allocate array as mutable array
    if (!self.resultArray) {
        self.resultArray = [[NSMutableArray alloc] init];
    }
    
    if (resultResponseDict && [resultResponseDict count] > 0) {
        
        //If this call is for Get Contact
        if ([resultResponseDict objectForKey:@"objects"] &&
            [[resultResponseDict objectForKey:@"objects"] count] > 0) {
            
            for (NSDictionary *contactDict in [resultResponseDict objectForKey:@"objects"]) {
                Contacts *contactObj = [[Contacts alloc] init];
                contactObj.name = [contactDict objectForKey:@"name"];
                //contactObj.contactId = [contactDict objectForKey:@"id_str"] ;
                contactObj.number=[contactDict objectForKey:@"number"];
                
                
                [self.resultArray addObject:contactObj];
            }
        } // Else if as send message response
        else if ([resultResponseDict objectForKey:@"acknowledgment"])  {
            
                [self.resultArray addObject:[resultResponseDict objectForKey:@"acknowledgment"]];
            
        }
        
    }
    //call delegate method
    //[self.delegate loadResultWithDataArray:self.resultArray];
}


@end
