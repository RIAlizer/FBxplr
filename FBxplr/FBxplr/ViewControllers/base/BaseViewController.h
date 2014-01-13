//
//  BaseViewController.h 
//
//  Created by andrea gonteri on 3/11/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIView+Positioning.h"
#import "UIView+Size.h"
#import "UIView+Animation.h"
#import "UIView+RoundCorners.h"
#import "DismissViewDelegate.h"
#import "UIColor+Hex.h"



@interface BaseViewController : UIViewController <MBProgressHUDDelegate>
{
     id<DismissViewDelegate> _dismissDelegate;
    MBProgressHUD *_HUD;
    
   
}
@property (nonatomic, strong) NSMutableIndexSet * optionIndices;
@property (MB_STRONG) id<DismissViewDelegate> dismissDelegate;
@property (MB_STRONG) MBProgressHUD * HUD;

- (id)initWithDeviceNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void)showActivity;

- (void)hideActivity;

-(IBAction)dismissSelf;

-(IBAction)back;

-(CGRect)getBounds;

-(void)setupUI;

-(void)updateUI;



 

-(void)showAlertWitTitle:(NSString*)title andMessage:(NSString*)message;
-(void)showAlertWitTitle:(NSString*)title andMessage:(NSString*)message andButtonTitle:(NSString*)buttonTitle;


@end
