//
//  AppWebService.m
//  FBFriends
//
//  Created by Ishan Weerasooriya on 5/26/16.
//  Copyright © 2016 Ishan Weerasooriya. All rights reserved.
//

#import "AppWebService.h"


@implementation AppWebService

+ (instancetype)defaultWebService {
    
    static AppWebService *defaultWebService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultWebService = [[self alloc] init];
    });
    
    return defaultWebService;
}


- (void)setImageView:(UIImageView *)imgView forUser:(FBUser *)fbUser {

    NSURL *url = [NSURL URLWithString:fbUser.picUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [imgView setImageWithURLRequest:request
                        placeholderImage:[UIImage imageNamed:@"avater"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                     
                                     imgView.image = image;
                                     
                                     
                                 } failure:nil];
}


@end
