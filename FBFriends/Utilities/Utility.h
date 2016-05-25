//
//  Utility.h
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/25/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

// Create singleton object 
+ (instancetype)sharedUtility;


- (NSArray *)getFBPermisions;

- (NSDictionary *)getFBGraphPermisions;

- (UIAlertController *)getAlertControllerWithTitle:(NSString *)title andBody:(NSString *)body;

@end
