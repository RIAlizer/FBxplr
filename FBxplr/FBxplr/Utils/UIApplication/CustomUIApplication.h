//
//  CustomUIApplication.h
//
//
//  Created by andrea gonteri on 12/9/11.
//  Copyright 2011 Rializer. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <execinfo.h>
#import <libkern/OSAtomic.h>



// error checking omitted
extern NSString* const MONExceptionHandlerDomain;
extern const int MONNSExceptionEncounteredErrorCode;



@interface CustomUIApplication : UIResponder <UIApplicationDelegate>
{
    BOOL _appWasSuspended;
    UITextView *_logView;
    
}




@property (MB_ASSIGN) BOOL appWasSuspended;
@property (MB_STRONG) UITextView * logView;

-(void)attachLogView;


//
//moreinfo @ http://stackoverflow.com/questions/8396326/exception-handling-in-entire-application

static inline  NSError * NewNSErrorFromException(NSException * exc) {
    NSMutableDictionary * info = [NSMutableDictionary dictionary];
    [info setValue:exc.name forKey:@"MONExceptionName"];
    [info setValue:exc.reason forKey:@"MONExceptionReason"];
    [info setValue:exc.callStackReturnAddresses forKey:@"MONExceptionCallStackReturnAddresses"];
    [info setValue:exc.callStackSymbols forKey:@"MONExceptionCallStackSymbols"];
    [info setValue:exc.userInfo forKey:@"MONExceptionUserInfo"];
    
    return [[NSError alloc] initWithDomain:MONExceptionHandlerDomain code:MONNSExceptionEncounteredErrorCode userInfo:info];
}

//- (void) redirectConsoleLogTo:(UITextView*) logView;

//+(void)showError:(NSError*)error;
//+(void)showException:(NSException*)exception;

@end