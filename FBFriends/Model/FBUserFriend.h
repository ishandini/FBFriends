//
//  FBUserFriend.h
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUserFriend : NSObject

+ (id)initWithFBUserFriendID:(NSString *)fbFriendID;

@property(strong, nonatomic)NSString *fbFriendID;
@property(strong, nonatomic)NSString *fullName;

@end
