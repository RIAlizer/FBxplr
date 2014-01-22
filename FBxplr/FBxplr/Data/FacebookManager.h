//
//  RestManager.h
 
//
//  Created by Daniele Salvioni on 21/05/12.
//  Copyright (c) 2012 JoinPad. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

//#define NEED_TO_CONFIRM_REGISTRATION @"NEED_TO_CONFIRM_REGISTRATION"

//extern NSString *const FBSessionStateChangedNotification;

@interface FacebookManager : NSObject
{
    FBSession *_session;
}
@property (MB_STRONG) NSString *  FBSessionStateChangedNotification;
@property (MB_STRONG) FBSession * session;


+(FacebookManager*)sharedInstance;


- (void)initData;
-(void)findFriendsWithCompletion:(void (^)(NSArray*))success failure:(void (^)(NSError *))failure;

@end
