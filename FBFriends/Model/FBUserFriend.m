//
//  FBUserFriend.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "FBUserFriend.h"

@implementation FBUserFriend


- (id)initFBUserFriend:(NSString *)fbFriendID {
    
    self = [super init];
    
    if(self) {
        [self setFbFriendID:fbFriendID];
    }
    return self;
}

+ (id)initWithFBUserFriendID:(NSString *)fbFriendID {
    
    return [[self alloc] initFBUserFriend:fbFriendID];
}

@end
