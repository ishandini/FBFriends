//
//  FriendCell.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "FriendCell.h"
#import "RoundImageView.h"
#import "UIImageView+AFNetworking.h"

@interface FriendCell()

@property (strong, nonatomic) IBOutlet RoundImageView *imgFriend;
@property (strong, nonatomic) IBOutlet UILabel *lblFriendName;


@end

@implementation FriendCell

- (void)configureCellForFriend:(FBUserFriend *)friend {

    self.lblFriendName.text = friend.fullName;
    
//    http://graph.facebook.com/1733916463487820/picture?type=large
    NSString *graphStringUrl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",friend.fbFriendID];
    
    NSURL *url = [NSURL URLWithString:graphStringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.imgFriend setImageWithURLRequest:request
                         placeholderImage:[UIImage imageNamed:@"avater"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                      
                                      self.imgFriend.image = image;
                                      
                                      
                                  } failure:nil];
    
}


@end
