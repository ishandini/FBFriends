//
//  FBUser.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "FBUser.h"

@implementation FBUser

- (id)initFBUser:(NSString *)fbUserID {
    
    self = [super init];
    
    if(self) {
        [self setFbUserID:fbUserID];
    }
    return self;
}

+ (id)initWithFBUserID:(NSString *)fbUserID {
    
    return [[self alloc] initFBUser:fbUserID];
}

@end
