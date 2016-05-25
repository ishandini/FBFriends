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

@interface FriendListViewController ()<FBManagerDelegate>

    @property(strong,nonatomic)FBManager *fbManager;
    @property(strong,nonatomic)Utility *sharedUtility;

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get utility instance
    self.sharedUtility = [Utility sharedUtility];
    self.fbManager = [FBManager sharedManager];
    
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



@end
