//
//  Contacts.m
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import "Contacts.h"
#import <objc/runtime.h>

@implementation Contacts
@synthesize name,number;

- (id)init{
    self = [super init];
    if (self) {
        name = @"";
        number = @"";
    }
    return self;
}
+ (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *pname = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:pname];
    }
    
    free(properties);
    
    return rv;
}

- (NSMutableArray *)getContactsFromDic:(NSDictionary *)resultResponseDict{

    NSMutableArray *resultArray = [[NSMutableArray alloc] init];

    if (resultResponseDict && [resultResponseDict count] > 0) {
    
        
        for (NSDictionary *contactDict in [resultResponseDict objectForKey:@"objects"]) {
            Contacts *contactObj = [[Contacts alloc] init];
            contactObj.name = [contactDict objectForKey:@"name"];
            contactObj.number=[contactDict objectForKey:@"number"];
            
            
            [resultArray addObject:contactObj];
        }
        
    }
        return resultArray;
}


@end
