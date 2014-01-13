//
//  AppManager.h
//  SkyGoAnalytics
//
//  Created by andrea gonteri on 28/10/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//


#import "SingletonHelper.h"

#import "KVCUtils.h"




/**
 `AppManager` is a singleton class that perform all resources's download in background from SharePoint.
 */


@interface AppManager : NSObject
{
}



@property (nonatomic, strong) UIWindow * mainWindow;
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



+(void)showError:(NSError*)error;
+(void)showException:(NSException*)exception;


@end
