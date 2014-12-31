//
//  ContactDetailViewController.h
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts.h"

@interface ContactDetailViewController : UIViewController{
    NSArray *arrPropertyName;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong)Contacts *contactObj;

@end
