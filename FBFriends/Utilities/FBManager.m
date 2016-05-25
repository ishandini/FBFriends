//
//  FBManager.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "FBManager.h"
#import "Utility.h"
#import "AppLogs.h"
#import "ConstantValue.h"
#import "FBUser.h"
#import "FBUserFriend.h"

@interface FBManager() {

    Utility *sharedUtility;
}

@end


@implementation FBManager

+ (instancetype)sharedManager {

    static FBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    
    return manager;
}


- (void)loginWithPermissionForViewController:(UIViewController *)viewController {
    
    sharedUtility = [Utility sharedUtility];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions: [sharedUtility getFBPermisions]
                 fromViewController:viewController
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                
                                if (error) {
                                    
                                    [self.delegate loginFailWithError:error.localizedDescription];
                                    
                                    
                                } else if (result.isCancelled) {
                                    
                                    [AppLogs print:@"Cancelled"];
                                    
                                } else {
                                    // confirm it's recived
                                    if ([result.grantedPermissions containsObject:KEY_EMAIL]) {
                                        
                                        [self.delegate loginSuccess];
                                    }
                                }
                            }];
}


- (void)fetchUserInfo {
    
    sharedUtility = [Utility sharedUtility];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:[sharedUtility getFBGraphPermisions]]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                
                 [self.delegate didReciveInformation:[self readUserInfo:result]];
                 
                 
             } else {
                
                 [AppLogs print:error.localizedDescription];
             }
         }];
        
    }
    
}


- (NSDictionary *)readUserInfo:(id)result {
    
    // user info
    NSString *fbUserId = [result objectForKey:@"id"];
    NSString *fullName = [result objectForKey:@"name"];
    NSString *imgUrl = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
    
    FBUser *fbUser = [FBUser initWithFBUserID:fbUserId];
    fbUser.fullName = fullName;
    fbUser.picUrl = imgUrl;
    
    
    // friends info
    NSArray *friendsDataArray = [[result objectForKey:@"friends"] objectForKey:@"data"];
    
    // create friend list array
    NSMutableArray *friendsListArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dicFriends in friendsDataArray) {
        
        NSString *friendId = [dicFriends objectForKey:@"id"];
        NSString *friendName = [dicFriends objectForKey:@"name"];
        
        FBUserFriend *userFriend = [FBUserFriend initWithFBUserFriendID:friendId];
        userFriend.fullName = friendName;
        
        [friendsListArray addObject:userFriend];
    }
    
    
    // finaly we need to return current user and friendlist array.
    // prefered to use Dictionary
    // KEY--  CURRENT_USER, FRIENDS_LIST
    
    NSDictionary *dicInfoResult = @{CURRENT_USER : fbUser, FRIENDS_LIST : friendsListArray};
    
    return dicInfoResult;
}

@end
