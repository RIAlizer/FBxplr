//
//  AppManager.m
//  SkyGoAnalytics
//
//  Created by andrea gonteri on 28/10/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "AppManager.h"


@implementation AppManager

#pragma mark - Properties


@synthesize mainWindow = _mainWindow;
@synthesize currentUser = _currentUser;

SYNTHESIZE_SINGLETON_FOR_CLASS(AppManager);

-(void)initAppData:(UIWindow*)window
{
    self.mainWindow = window;
    
    LogTrace(@"AppManager initAppData");
  
}

-(void)setCurrentUser:(User *)currentUser
{
    _currentUser = currentUser;
    
    UserCD * registeredUser = [[CoreDataManager sharedInstance] getUserWithUID:currentUser.uid];;
    
    if(registeredUser){
        [[CoreDataManager sharedInstance] mapUser:_currentUser fromUserCD:registeredUser];
    }
    
    

}

-(void)releaseResources
{
    
    //RELEASE_OBJ(_productMenuViewController);
    
    
}
 
#pragma mark - Error Handling


+(void)showError:(NSError*)error
{
    //ULog(@" ************* NSError: Caught %@:", error);
    
    [AppManager showException:[NSException exceptionWithName:@"Error" reason:[error localizedDescription] userInfo:[error userInfo]]];
}


+(void)showException:(NSException*)exception
{
    if(NO)//DEBUG)
    {
        ULog(@" ************* NSException: Caught %@: %@", [exception name], [exception reason]);
    }
    else
    {
        NSString *msg = [NSString stringWithFormat:@"Errore %@: %@", [exception name], [exception reason]];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Errore" message:msg  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        RELEASE_OBJ(alert);
    }
    
    
    
}

-(BOOL)saveUser:(User*)user
{
    BOOL saved = [[CoreDataManager sharedInstance] saveUser:user];
    if(saved)
        self.currentUser = user;
    return saved;
    
}
#pragma mark - Object lifecycle

- (void)dealloc
{
    
    SUPER_DEALLOC();
}

@end
