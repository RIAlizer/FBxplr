//
//  LoginViewController.m
//  FBxplr
//
//  Created by andrea gonteri on 13/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "LoginViewController.h"
#import "FriendsViewController.h"

@implementation LoginViewController

#pragma mark - Memeroy Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_buttonFriends release];
    [_buttonNext release];
    RELEASE_OBJ(_profilePictureView);
    RELEASE_OBJ(_labelName);
    
    RELEASE_OBJ(_loginButtonView);
    RELEASE_OBJ(_loginButtonView);
    SUPER_DEALLOC();
}

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _firstLoad = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupUI];
    
}

-(void)setupUI
{
    /*
     NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
     NSMutableArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
     [languages insertObject:@"it" atIndex:0]; // ISO639-1
     [[NSUserDefaults standardUserDefaults] synchronize];
     */
    self.navigationItem.title = LSTR(@"Login");
    self.loginButtonView.delegate = self;
    
    CGPoint newPosition = CGPointMake(55, 100);
    [self.loginButtonView setFrame:CGRectMake(newPosition.x , newPosition.y, self.loginButtonView.frame.size.width, self.loginButtonView.frame.size.height)];
    
    //buttonNext
    self.buttonNext.alpha = 0;
    self.buttonNext.buttonColor = [UIColor turquoiseColor];
    self.buttonNext.shadowColor = [UIColor greenSeaColor];
    self.buttonNext.shadowHeight = 3.0f;
    self.buttonNext.cornerRadius = 6.0f;
    self.buttonNext.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.buttonNext setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.buttonNext setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
   
    //buttonFriends
    self.buttonFriends.alpha = 0;
    self.buttonFriends.buttonColor = [UIColor turquoiseColor];
    self.buttonFriends.shadowColor = [UIColor greenSeaColor];
    self.buttonFriends.shadowHeight = 3.0f;
    self.buttonFriends.cornerRadius = 6.0f;
    self.buttonFriends.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.buttonFriends setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.buttonFriends setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
   
    
    /*
     NSArray *permissions = @[
     @"user_likes",
     @"read_stream",
     @"email",
     @"user_location",
     @"user_hometown",
     @"user_about_me",
     @"user_birthday",
     @"user_events"];
     */
    NSArray *permissions =@[@"basic_info", @"email", @"user_likes"];
    
    self.loginButtonView.readPermissions = permissions;
    
    self.profilePictureView.backgroundColor = [UIColor clearColor];
    
    self.profilePictureView.alpha = 0;
    [self.profilePictureView setRoundCorners:70];
    
    self.labelName.alpha = 0;
    
}

#pragma mark - FBLoginViewDelegate
// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    
    User * currenUser =[[User alloc] init];
    currenUser.uid = user.id;
    currenUser.name = user.name;
    currenUser.first_name = user.first_name;
    currenUser.last_name = user.last_name;
    currenUser.middle_name = user.middle_name;
    currenUser.birthday = user.birthday;
    currenUser.username = user.username;
    currenUser.link = user.link;
    
    [[AppManager sharedInstance] setCurrentUser:currenUser];
    
    self.profilePictureView.profileID = user.id;
    self.labelName.text = [NSString stringWithFormat:LSTR(@"Welcome %@"),user.name];
    
    
    
}

-(void)showUserUI
{
    [self.profilePictureView fadeInWithDuration:DEFAULT_FADE_IN_DURATION];
    [self.labelName fadeInWithDuration:DEFAULT_FADE_IN_DURATION];
    
    [self.buttonNext  fadeInWithDuration:DEFAULT_FADE_IN_DURATION];
    [self.buttonFriends  fadeInWithDuration:DEFAULT_FADE_IN_DURATION];
    
}

-(void)hideUserUI
{
    [self.profilePictureView fadeOutWithDuration:DEFAULT_FADE_OUT_DURATION];
    [self.labelName fadeOutWithDuration:DEFAULT_FADE_OUT_DURATION];
    
    [self.buttonNext  fadeOutWithDuration:DEFAULT_FADE_OUT_DURATION];
    [self.buttonFriends  fadeOutWithDuration:DEFAULT_FADE_OUT_DURATION];

    
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
  
    self.navigationItem.title = LSTR(@"Welcome");
    
    CGPoint newPosition = CGPointMake(55, 400);
    [self.loginButtonView moveTo:newPosition duration:DEFAULT_FADE_IN_DURATION option:UIViewAnimationOptionCurveEaseIn delegate:self callback:@selector(showUserUI)];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{

//    if(_firstLoad){
//        _firstLoad = NO;
//        return;
//    }
    self.navigationItem.title = LSTR(@"Login");
    CGPoint newPosition = CGPointMake(55, 100);
    [self.loginButtonView moveTo:newPosition duration:DEFAULT_FADE_OUT_DURATION option:UIViewAnimationOptionCurveEaseOut delegate:self callback:@selector(hideUserUI)];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSString *alertMessage = nil;
    NSString *alertTitle = nil;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        LogInfo(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        LogError(@"Unexpected error:%@", error);
    }
    alertMessage = [FBErrorUtility userMessageForError:error];
    if (!alertMessage)
    {
        alertMessage =@"FB Error";
        alertMessage = [error localizedDescription];
    }
    
       
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMessage
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil] ;
        [alertView show];
        RELEASE_OBJ(alertView);
        
    
}

#pragma mark Actions


- (IBAction)pushNextView:(id)sender
{
    
    UserInfoViewController *userInfoViewController = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
    [self.navigationController pushViewController:userInfoViewController animated:YES];
    RELEASE_OBJ(userInfoViewController);
}

- (IBAction)pushFriendsView:(id)sender
{
    FriendsViewController *friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
    [self.navigationController pushViewController:friendsViewController animated:YES];
    RELEASE_OBJ(friendsViewController);
    
}
@end
