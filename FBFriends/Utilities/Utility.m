//
//  Utility.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (instancetype)sharedUtility {
    
    static Utility *utility;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utility = [[self alloc] init];
    });
    
    return utility;
}


- (NSArray *)getFBPermisions {

    // We can add more permissions,
    // but this FB app never go through Review process... have to think about it.
    return [[NSArray alloc] initWithObjects:@"email", @"public_profile", @"user_friends", nil];
}

- (NSDictionary *)getFBGraphPermisions {

    return @{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, friends, friendlists"};
}


- (UIAlertController *)getAlertControllerWithTitle:(NSString *)title andBody:(NSString *)body {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"") style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    return alertController;
}




@end
