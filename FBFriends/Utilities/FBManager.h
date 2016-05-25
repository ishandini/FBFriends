//
//  FBManager.h
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@protocol FBManagerDelegate

@optional
- (void)loginFailWithError:(NSString *)error;
- (void)loginSuccess;
- (void)didReciveInformation:(NSDictionary *)dicInfo;


@end

@interface FBManager : NSObject

+ (instancetype)sharedManager;


@property(strong, nonatomic)id <FBManagerDelegate> delegate;

- (void)loginWithPermissionForViewController:(UIViewController *)viewController;

- (void)fetchUserInfo;

@end
