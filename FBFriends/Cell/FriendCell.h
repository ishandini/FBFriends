//
//  FriendCell.h
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBUserFriend.h"

@interface FriendCell : UITableViewCell

- (void)configureCellForFriend:(FBUserFriend *)friend;

@end
