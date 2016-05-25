//
//  FriendListViewController.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "FriendListViewController.h"
#import "FBManager.h"
#import "AppLogs.h"
#import "Utility.h"
#import "ConstantValue.h"
#import "FBManager.h"
#import "AppDelegate.h"
#import "FBUser.h"
#import "RoundImageView.h"
#import "AppWebService.h"
#import "UIImageView+AFNetworking.h"
#import "FBUserFriend.h"
#import "FriendCell.h"


@interface FriendListViewController ()<FBManagerDelegate, UITableViewDataSource>

    @property(strong,nonatomic)FBManager *fbManager;
    @property(strong,nonatomic)Utility *sharedUtility;
    @property(strong, nonatomic)FBUser *currentFbUser;
    @property(strong, nonatomic)NSArray *friendListArray;

@property (strong, nonatomic) IBOutlet RoundImageView *imgUser;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get utility instance
    self.sharedUtility = [Utility sharedUtility];
    self.fbManager = [FBManager sharedManager];
    
    // initialize empty array, load data through delegate methods
    self.friendListArray = [[NSArray alloc] init];
    
    [self getUserInfoWithFriendList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getUserInfoWithFriendList {

    self.fbManager.delegate = self;
    [self.fbManager fetchUserInfo];
}



#pragma mark - Button Actions

- (IBAction)logOutPressed:(id)sender {
    
    // remove access token
    [FBSDKAccessToken setCurrentAccessToken:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate validateFBUserSession];
}


#pragma mark - FBManager Delegates

- (void)didReciveInformation:(NSDictionary *)dicInfo {

    self.currentFbUser = [dicInfo objectForKey:CURRENT_USER];
    self.friendListArray = [dicInfo objectForKey:FRIENDS_LIST];
    
    // now data available, we can refresh current UIView
    [self updateUI];
}

- (void)updateUI {
    
    // user info
    self.lblUserName.text = self.currentFbUser.fullName;
    [[AppWebService defaultWebService] setImageView:self.imgUser forUser:self.currentFbUser];
    
    
    //friends things..
    if(self.friendListArray.count > 0) {
        
        [self.tblView reloadData];
        
    } else {
    
        // no friends using FB App,
        
        if ([UIAlertController class]) {
            UIAlertController *altController = [self.sharedUtility getAlertControllerWithTitle:@"" andBody:NSLocalizedString(@"no_user_message", nil)];
            [self presentViewController:altController animated:YES completion:nil];
        }
        
        UILabel *lblNoResult = [[UILabel alloc]initWithFrame:self.tblView.frame];
        lblNoResult.text =@"No Result";
        lblNoResult.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        lblNoResult.backgroundColor = [UIColor clearColor];
        lblNoResult.textColor = [UIColor lightGrayColor];
        lblNoResult.textAlignment = NSTextAlignmentCenter;
        [lblNoResult setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f]];
        [self.view addSubview:lblNoResult];
        [self.tblView setHidden:YES];
    }

}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friendListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FBUserFriend *friend = [self.friendListArray objectAtIndex:indexPath.row];
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    [cell configureCellForFriend:friend];
    
    return cell;
    
}

@end
