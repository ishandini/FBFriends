//
//  RoundImageView.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "RoundImageView.h"

@implementation RoundImageView


- (void)awakeFromNib {

    self.layer.cornerRadius = self.layer.bounds.size.width / 2.0;
    self.clipsToBounds = YES;
}

@end
