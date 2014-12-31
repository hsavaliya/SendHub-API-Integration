//
//  ContactsViewController.h
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendHubAPIService.h"

@interface ContactsViewController : UIViewController<SendHubAPIServiceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) SendHubAPIService *sendHubService;
@property (nonatomic, strong) NSMutableArray *arrContacts;
-(void)getSendHubContacts;
@end
