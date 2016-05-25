//
//  LoginViewController.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "LoginViewController.h"
#import "AppLogs.h"
#import "RoundCornerButton.h"
#import "Utility.h"
#import "ConstantValue.h"
#import "FBManager.h"
#import "AppDelegate.h"



@interface LoginViewController()<FBManagerDelegate>

    @property(strong,nonatomic)FBManager *fbManager;
    @property(strong,nonatomic)Utility *sharedUtility;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    // get utility instance
    self.sharedUtility = [Utility sharedUtility];
    self.fbManager = [FBManager sharedManager];
    
}


- (void)didReceiveMemoryWarning {
    
    [AppLogs print:@"did Recieve memory warning"];
    
}





#pragma mark - Button Actions

- (IBAction)loginButtonPressed:(id)sender {
    
    // Better if I can check internet availability befor this action..
    
    self.fbManager.delegate = self;
    [self.fbManager loginWithPermissionForViewController:self];
  
}






#pragma mark - FBManager Delegates

- (void)loginFailWithError:(NSString *)error {

     [AppLogs print:error];
    // this alert works only on iOS 8 or later, older version need to use UIAlertView... but I'm busy :D
    if ([UIAlertController class]) {
        UIAlertController *altController = [self.sharedUtility getAlertControllerWithTitle:NSLocalizedString(@"action_error", nil) andBody:error];
        [self presentViewController:altController animated:YES completion:nil];
    }
}


- (void)loginSuccess {
    
    // login succsss, what's needs to do in here..?
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate validateFBUserSession];
    
}





#pragma mark - More info

/*
 
 // this is the format I'm getting friends list, It's not return all users only whos is using FBApp. 
 // more: http://stackoverflow.com/questions/23417356/facebook-graph-api-v2-0-me-friends-returns-empty-or-only-friends-who-also-u
 

{
    email = "ishandini@live.com";
    "first_name" = Ishan;
    friends =     {
        data =         (
                        {
                            id = 1185635514822527;
                            name = "Janu Weerasekara";
                        },
                        {
                            id = 1733916463487820;
                            name = "Janu Weerasekara";
                        }
                        );
        paging =         {
            cursors =             {
                after = QVFIUkZAadTVHRzAxU2xpenhZATTBnNEtaTm5VUEJYeGIwbkRpSVFKMHdrMGp0TXF6MmVOZAlhHSGV5dDBrTnhjeG5XcnFxX2pNMFFfM0ZA2ZATFBb3RVV2JFSXZAn;
                before = QVFIUm9qVXgyWDIzcnRIcVFvMGNuc2tvU0dBQ2VvVHhIVDk4LWlSWkI4bEozWTlzeE9MRTRuQ0hrY0R1Q1g0bEhEQnE2RGl5N2dGczA5QlNMOWdWTkNsRm53;
            };
        };
        summary =         {
            "total_count" = 526;
        };
    };
    id = 10208312293458189;
    "last_name" = Weerasooriya;
    link = "https://www.facebook.com/app_scoped_user_id/10208312293458189/";
    name = "Ishan Weerasooriya";
    picture =     {
        data =         {
            "is_silhouette" = 0;
            url = "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/10537425_10203574606778983_7321109744206687860_n.jpg?oh=c77b2825606f376a6fff7d9d9a017bf3&oe=57CFA0D1";
        };
    };
}

*/

@end
