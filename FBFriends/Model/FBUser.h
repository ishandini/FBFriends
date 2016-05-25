//
//  FBUser.h
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUser : NSObject

+ (id)initWithFBUserID:(NSString *)fbUserID;

@property(strong, nonatomic)NSString *fbUserID;
@property(strong, nonatomic)NSString *fullName;
@property(strong, nonatomic)NSString *picUrl;

@end
