//
//  SendHubAPIService.h
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import <Foundation/Foundation.h>


//Create delegate class to handle asunchronous request on each separate controller
@protocol SendHubAPIServiceDelegate <NSObject>
//-(void)loadResultWithDataArray:(NSArray *)resultArray;
-(void)loadResultWithDataDict:(NSDictionary *)resultDict;
@end


@interface SendHubAPIService : NSObject
@property(nonatomic, strong) NSMutableData *urlRespondData;
@property(nonatomic, strong) NSString *responseString;
@property(nonatomic, strong) NSMutableArray *resultArray;

@property (weak, nonatomic) id <SendHubAPIServiceDelegate> delegate;

//Collect contact information
-(void)collectContactsByFilter;
-(void)sendMessage:(NSString *)contact andText:(NSString *)message;
@end
