//
//  ContactsViewController.m
//  SendHubAPISample
//
//  Created by Hetal Savaliya on 10/16/14.
//  Copyright (c) 2014 Hetal Savaliya. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactDetailViewController.h"
#import "Contacts.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

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
    if (!self.arrContacts) {
        self.arrContacts = [[NSMutableArray alloc] init];
    }
    //initialise webservice class
    self.sendHubService = [[SendHubAPIService alloc] init];
    self.sendHubService.delegate = self;
    
   // show emty table
    [self.arrContacts removeAllObjects];
    [self.tableView reloadData];
    
    
    //call web service to get contact information
    self.lblMessage.text = @"Fetching results..";
    self.activityIndicator.hidden = NO;
    [self.sendHubService collectContactsByFilter];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getSendHubContacts{
    
}
# pragma mark - SendHub API Delegate Method

-(void)loadResultWithDataDict:(NSDictionary *)resultDict {
    //hide activity indicator
    self.activityIndicator.hidden = YES;
    
    //load table with result
    if ([resultDict objectForKey:@"objects"] &&
        [[resultDict objectForKey:@"objects"] count] > 0) {
        
        self.arrContacts = [[[Contacts alloc]init] getContactsFromDic:resultDict];
    }
    [self.tableView reloadData];
    
    //set message according to result
    if ([self.arrContacts count] > 0) {
        self.lblMessage.text =[NSString stringWithFormat:@""];
    }
    
    else {
        self.lblMessage.text =[NSString stringWithFormat:@"I could not find any contacts"];
    }
}
# pragma mark - TableView Datasource and Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)TableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cellContacts";
    UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    Contacts *contactObj    = (Contacts *)[self.arrContacts objectAtIndex:indexPath.row];
    cell.textLabel.text = contactObj.name;
    
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showContactDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ContactDetailViewController *destViewController = segue.destinationViewController;
        //pass contact information to the next controller
        destViewController.contactObj = (Contacts *)[self.arrContacts objectAtIndex:indexPath.row];
    }
}


@end
