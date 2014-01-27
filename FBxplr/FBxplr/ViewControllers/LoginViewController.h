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

@interface LoginViewController : BaseViewController<FBLoginViewDelegate>
{
    
}
@property (MB_STRONG) IBOutlet FBLoginView *loginButtonView;
@property (MB_STRONG) IBOutlet FBProfilePictureView *profilePictureView;
@property (MB_STRONG) IBOutlet UILabel *labelName;
@property (retain, nonatomic) IBOutlet UIButton *buttonNext;
- (IBAction)pushNextView:(id)sender;

@end
