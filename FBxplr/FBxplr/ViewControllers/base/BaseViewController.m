//
//  BaseViewController.m
//
//  Created by andrea gonteri on 3/11/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "BaseViewController.h"

#define DEFAULT_HUD_MESSAGE								LSTR(@"Loading")
#define DEFAULT_HUD_DETAILED_MESSAGE					LSTR(@"Retrieving Data")
#define DEFAULT_HUD_PROGRESS_MODE						MBProgressHUDModeIndeterminate
#define MINIMUM_ACTIVITY_TIME_PRESENCE 1


@implementation BaseViewController



#pragma mark - Properties

@synthesize HUD = _HUD;


#pragma mark - Memory Management

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    // NULLME(self.labelTitle);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
    // RELEASE_OBJ(_labelTitle);
    SUPER_DEALLOC();
}


#pragma mark - Init

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 //custom init Universal Apps
 self = [super initWithNibName: [self chooseNibName:nibNameOrNil] bundle:nibBundleOrNil];
 
 if (self) {
 // Custom initialization
 }
 
 return self;
 }
 */

- (id)initWithDeviceNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //custom init Universal Apps
    self = [super initWithNibName: [self chooseNibName:nibNameOrNil] bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        
    }
    
    return self;
}
#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    /*if(IS_IPAD)
     {
     
     return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
     }
     else
     {
     return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
     }*/
    return YES;
}


#pragma mark - Private

- (NSString*)chooseNibName:(NSString*)nibName
{
    BOOL exist = NO;
    ALog(@"nibName: %@", nibName);
    NSString * deviceNibName = nil;
    
	if  ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
	{
        deviceNibName = [NSString stringWithFormat:@"%@~iPad",nibName];
        
    }
    else
    {
        deviceNibName = [NSString stringWithFormat:@"%@",nibName];
        
    }
    
    
    //check if exist
    exist = [[NSBundle mainBundle] pathForResource:deviceNibName ofType:@"xib"] != nil;
    if(exist)
    {
        return deviceNibName;
        
    }
    else
    {
        ALog(@"nibName: %@ NOT EXIST", nibName);
        return nibName;
    }
    
    return deviceNibName;
}


#pragma mark - Custom methods

-(void)setupUI
{
    
}

-(void)updateUI
{
    
}


#pragma mark - Activity methods

- (void)showActivity
{
    [self showActivityWithMessage:DEFAULT_HUD_MESSAGE withDetailedMessage:DEFAULT_HUD_DETAILED_MESSAGE andProgressMode:DEFAULT_HUD_PROGRESS_MODE];
}

- (void)showActivityWithMessage:(NSString *)inputText withDetailedMessage:(NSString *)inputDetailedText andProgressMode:(MBProgressHUDMode)inputHUDMode
{
    
    if (self.HUD!=nil)
    {
        [self.HUD hide:YES];
    }
    
    
    
	
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.animationType = MBProgressHUDAnimationFade;
    [self.view addSubview:self.HUD ];
	[self.view  bringSubviewToFront:self.HUD ];
	
	// Set mode
	self.HUD.mode = inputHUDMode;
    
    // self.HUD.dimBackground = YES;
    
	self.HUD.delegate = self;
	self.HUD.labelText = inputText;
	//self.HUD.detailsLabelText = inputDetailedText;
    self.HUD.minShowTime= MINIMUM_ACTIVITY_TIME_PRESENCE;
    
    
    [ self.view  bringSubviewToFront:self.HUD];
    
    
    
}
#pragma mark - Dismiss/Back

-(IBAction)dismissSelf
{
    
    if (self.dismissDelegate != nil) {
        [self.dismissDelegate didDismissModalView:self];
    }
	[self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


-(IBAction)back
{
    
    
	if(self.navigationController!=nil)
	{
        [self.navigationController popViewControllerAnimated:YES];
        if (self.dismissDelegate != nil)
        {
            [self.dismissDelegate didDismissModalView:self];
            
        }
	}
	else
	{
		LogInfo(@"back: self.navigationController is NIL");
        [self dismissSelf];
	}
    
    
}

-(CGRect)getBounds
{
    return [[UIScreen mainScreen] bounds];
    //  return self.view.bounds;
}



#pragma mark - Static Utility

/*
-(void)showAlertWitTitle:(NSString*)title andMessage:(NSString*)message
{
   // [self showAlertWitTitle:title andMessage:message andButtonTitle:@"OK"];
    [TSMessage showNotificationInViewController:self title:title subtitle:message type:TSMessageNotificationTypeSuccess];
 

}

-(void)showAlertWitTitle:(NSString*)title andMessage:(NSString*)message andButtonTitle:(NSString*)buttonTitle
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:buttonTitle
                                          otherButtonTitles: nil];
    [alert show];
    RELEASE(alert);
    
    
}
*/
-(void)showErrorWitTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    RELEASE(alert);
}

#pragma mark MBProgressHUDDelegate

- (void)hudWasHidden
{
	// Remove HUD from screen when the HUD was hidded
    if(_HUD){
        [_HUD removeFromSuperview];
        RELEASE_OBJ(_HUD);
    }
    
}


- (void)hideActivity
{
    
    [self.HUD hide:YES];
}





#pragma mark iOS 7 fixing

-(void)addFakeStatusBarUI{
    return;
    
    
    if (IS_IOS7) {
        //IS LANDSCAPE > window is always in portrait, frame will be rotated
        self.view.clipsToBounds =YES;
        ALog(@" %@", NSStringFromCGRect(self.view.frame));
        //window is always in portrait
        self.view.frame =  CGRectMake(0, STATUS_BAR_HEIGHT, self.view.frame.size.width,self.view.frame.size.height-STATUS_BAR_HEIGHT);
        ALog(@" %@", NSStringFromCGRect(self.view.frame));
        //Added on 19th Sep 2013
        //self.view.bounds = CGRectMake(20, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        UIView *fakeStatusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, STATUS_BAR_HEIGHT)];
        fakeStatusBar.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3f];
        [self.view insertSubview:fakeStatusBar atIndex:0];
        
        RELEASE_OBJ(fakeStatusBar);
        
    }
}




-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
// Add this Method
- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
