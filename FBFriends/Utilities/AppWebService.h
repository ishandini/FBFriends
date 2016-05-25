//
//  AppWebService.h
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FBUser.h"
#import "UIImageView+AFNetworking.h"

@protocol AppWebServiceDelegate


@end



@interface AppWebService : NSObject

+ (instancetype)defaultWebService;

@property(strong,nonatomic) id <AppWebServiceDelegate> delegate;


- (void)setImageView:(UIImageView *)imgView forUser:(FBUser *)fbUser;


@end
