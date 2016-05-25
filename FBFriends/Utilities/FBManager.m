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
                 NSLog(@"resultis: %@",result);
                 
             } else {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}

@end
