//
//  AppManager.h
//  SkyGoAnalytics
//
//  Created by andrea gonteri on 28/10/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//


#import "SingletonHelper.h"
#import "CoreDataManager.h"
#import "KVCUtils.h"
#import "User.h"




/**
 `AppManager` is a singleton class that perform all resources's download in background from SharePoint.
 */


@interface AppManager : NSObject
{
}



@property (MB_STRONG) UIWindow * mainWindow;
@property (MB_STRONG) User * currentUser;
///--------------
/// @name Class Methods
///--------------

/**
 Shared instance
 
 Return a singleton `VTDownloadManager`
 */

+ (AppManager *)sharedInstance;

-(void)initAppData:(UIWindow*)window;


-(void)releaseResources;

-(BOOL)saveUser:(User*)user;

+(void)showError:(NSError*)error;
+(void)showException:(NSException*)exception;


@end
