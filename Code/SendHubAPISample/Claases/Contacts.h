//
//  Contacts.h
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contacts : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;

+ (NSArray *)allPropertyNames;
- (NSMutableArray *)getContactsFromDic:(NSDictionary *)resultResponseDict;
@end
