//
//  ContactDetailViewController.m
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "ComposeMessageViewController.h"


@interface ContactDetailViewController ()

@end

@implementation ContactDetailViewController

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
    //set lable and navigation text as contact information
    self.navigationItem.title = self.contactObj.name;
    
   arrPropertyName= [Contacts allPropertyNames];
    //class_copyPropertyList(cls,&count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Message

-(IBAction)sendMessageButtonPressed:(id)sender{
    [self performSegueWithIdentifier:@"ShowComposeMessage" sender:sender];
    
}

# pragma mark - TableView Datasource and Delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section ==0)
        return [arrPropertyName count];
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)TableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cellContactDetail";
    UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(indexPath.section==0)
    {
        NSString* propname = [arrPropertyName objectAtIndex:indexPath.row];
        NSString* propvalue = [self.contactObj valueForKey:propname];
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", propname, propvalue];
    }
    else if (indexPath.section==1)
    {
     //
        UIButton *btnSendMessage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnSendMessage.frame = CGRectMake(10.0f, 5.0f, 280.0f, 35.0f);
        btnSendMessage.backgroundColor=[UIColor blackColor];
        [btnSendMessage setTitle:@"Send Message" forState:UIControlStateNormal];
        [cell addSubview:btnSendMessage];
        [btnSendMessage addTarget:self action:@selector(sendMessageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowComposeMessage"]) {
        ComposeMessageViewController *destViewController = segue.destinationViewController;
        
        //pass contact id to destination view controller
        destViewController.contactNumber = self.contactObj.number;
    }
}



@end
