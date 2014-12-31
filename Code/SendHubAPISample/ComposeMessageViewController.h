//
//  ComposeMessageViewController.h
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendHubAPIService.h"

@interface ComposeMessageViewController : UIViewController<SendHubAPIServiceDelegate>
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) SendHubAPIService *sendHubService;
@property (nonatomic, strong) NSString *contactNumber;
- (IBAction)btnSendMessageClicked:(id)sender;

@end
