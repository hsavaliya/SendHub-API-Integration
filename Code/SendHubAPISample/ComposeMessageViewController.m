//
//  ComposeMessageViewController.m
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import "ComposeMessageViewController.h"

@interface ComposeMessageViewController ()

@end

@implementation ComposeMessageViewController
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]
#pragma mark Private methods
/* Method call on click on "Send". this method call send message api */
- (IBAction)btnSendMessageClicked:(id)sender {
    /* initialise delegate */
    self.sendHubService = [[SendHubAPIService alloc] init];
    self.sendHubService.delegate = self;
    
    /* validate message */
    if ( [allTrim( self.txtMessage.text ) length] == 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                        message:@"Message field should not be empty"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        //set message and sctivity indicator
        self.lblMessage.hidden=false;
        self.lblMessage.text = @"Sending message..";
        self.activityIndicator.hidden = false;
        
        //call send message api
        [self.sendHubService sendMessage:self.contactNumber andText:self.txtMessage.text];
    }
}

-(void)doneButtonClickedDismissKeyboard
{
    [self.txtMessage resignFirstResponder];
}
-(void)addDoneToolBarToKeyboard:(UITextView *)textView
{
    UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    doneToolbar.barStyle = UIBarStyleBlackTranslucent;
    doneToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)],
                         nil];
    [doneToolbar sizeToFit];
    textView.inputAccessoryView = doneToolbar;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"compose message";
    self.lblMessage.hidden=true;
    self.activityIndicator.hidden=true;
    [self addDoneToolBarToKeyboard:self.txtMessage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textfield delegate
-(BOOL) textFieldShouldReturn:(UITextView *)textview{
    //Hide keyboard
    [textview resignFirstResponder];
    return YES;
}

# pragma mark - SendHub API Delegate Method

-(void)loadResultWithDataDict:(NSDictionary *)resultDict {
    
    self.activityIndicator.hidden=true;
     if (resultDict && [resultDict count] > 0) {
         self.lblMessage.text =[resultDict objectForKey:@"acknowledgment"];
     }
    else
        self.lblMessage.text =@"please try later";
}

@end
