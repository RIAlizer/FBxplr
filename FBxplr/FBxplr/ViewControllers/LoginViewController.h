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
@interface LoginViewController : BaseViewController<FBLoginViewDelegate>
{
    
}
@property (retain, nonatomic) IBOutlet FBLoginView *loginButtonView;
@property (retain, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;

@property (retain, nonatomic) IBOutlet UILabel *labelName;

@end
