
//
//  FacebookManager.m

//
//  Created by Daniele Salvioni on 21/05/12.
//  Copyright (c) 2012 JoinPad. All rights reserved.
//

#import "FacebookManager.h"
#import "Friend.h"


@implementation FacebookManager

//@synthesize session = _session;

@synthesize FBSessionStateChangedNotification;

//NSString *const FBSessionStateChangedNotification = [NSString stringWithFormat: @"%@:FBSessionStateChangedNotification",BUNDLE_ID];
SYNTHESIZE_SINGLETON_FOR_CLASS(FacebookManager);
#define BUNDLE_ID @"FBxplr"

-(void)initData
{
    FBSessionStateChangedNotification = [NSString stringWithFormat: @"%@:FBSessionStateChangedNotification",BUNDLE_ID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateChanged:) name:FBSessionStateChangedNotification object:nil];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        //[self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
    } else {
        // [self.authButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}

-(void)findFriendsWithCompletion:(void (^)(NSArray*))success failure:(void (^)(NSError *))failure
{
    NSDictionary * parameters = @{@"fields": @"picture.type(square).width(200),name,website,gender"};
    
    [FBRequestConnection startWithGraphPath:@"/me/friends"
                                 parameters:parameters
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              
                              if(error){
                                  failure(error);
                              }
                              else
                              {
                                  if([result isKindOfClass:[NSDictionary class]])
                                  {
                                      
                                      
                                      NSDictionary *resultDict = (NSDictionary *)result;
                                      NSArray *resultArray = [resultDict objectForKey:@"data"];
                                    
                                      
                                      NSMutableArray * friends = [NSMutableArray new];
                                      Friend *item;
                                      for (NSDictionary *dict in resultArray)
                                      {
                                          item = [[Friend alloc] initWithDictionary:dict];
                                          [friends addObject:item];
                                      }
                                      
                                      
                                      
                                      
                                      success(friends);
                                  }
                                  else
                                  {
                                      
                                  }
                                  
                              }
                          }];
}
//--------------------------------------------------------------
/*- (void) dealloc
 {
 [[NSNotificationCenter defaultCenter] removeObserver:self];
 [super dealloc];
 }
 */
@end