//
//  LoginViewController.h
//  FBxplr
//
//  Created by andrea gonteri on 13/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "FacebookSDK.h"
#import "UIView+RoundCorners.h"

#import "User.h"
#import "UserInfoViewController.h"

@interface LoginViewController : BaseViewController<FBLoginViewDelegate>
{
    BOOL _firstLoad;
}
@property (MB_STRONG) IBOutlet FBLoginView *loginButtonView;
@property (MB_STRONG) IBOutlet FBProfilePictureView *profilePictureView;
@property (MB_STRONG) IBOutlet UILabel *labelName;
@property (MB_STRONG) FUIButton *buttonNext;
@property (retain, nonatomic) IBOutlet FUIButton *buttonFriends;

- (IBAction)pushNextView:(id)sender;
- (IBAction)pushFriendsView:(id)sender;

@end
