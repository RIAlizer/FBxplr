
//
//  CustomUIApplication.m
//
//
//  Created by andrea gonteri on 12/9/11.
//  Copyright 2011 Rializer. All rights reserved.
//

#import "CustomUIApplication.h"


#import "NSMutableAttributedString+Attributes.h"
#import "UncaughtExceptionHandler.h"

NSString* const MONExceptionHandlerDomain = ERROR_DOMAIN;
const int MONNSExceptionEncounteredErrorCode = ERROR_DEFAULT_ERROR_CODE;



@implementation CustomUIApplication

@synthesize appWasSuspended = _appWasSuspended;
@synthesize logView = _logView;





+ (void)initialize
{
    
    
    //Global exception handling
    //NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleMemoryWarning) name:@"UIApplicationMemoryWarningNotification" object:nil];
    
}

- (void)installUncaughtExceptionHandler
{
	InstallUncaughtExceptionHandler();
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if USE_GLOBAL_EXCEPTIONS_HANDLER
    [self performSelector:@selector(installUncaughtExceptionHandler) withObject:nil afterDelay:0];
    
    // [self NSNotificationCatchAll];
    
    //[self performSelector:@selector(string) withObject:nil afterDelay:4.0];
	//[self performSelector:@selector(badAccess) withObject:nil afterDelay:10.0];
#endif
    
    
    return YES;
}
//catch any Notification dispatched by [NSNotificationCenter defaultCenter]
-(void)NSNotificationCatchAll
{
    NSNotificationCenter *notifyCenter = [NSNotificationCenter defaultCenter];
    [notifyCenter addObserverForName:nil
                              object:nil
                               queue:nil
                          usingBlock:^(NSNotification* notification){
                              // Explore notification
                              NSLog(@"Notification found with:"
                                    "\r\n     name:     %@"
                                    "\r\n     object:   %@"
                                    "\r\n     userInfo: %@",
                                    [notification name],
                                    [notification object],
                                    [notification userInfo]);
                          }];
}

- (void)badAccess
{
    void (*nullFunction)() = NULL;
    
    nullFunction();
}


-(void)handleMemoryWarning
{
    NSLog(@"%@ %@",[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSASCIIStringEncoding],@"Should I manage handleMemoryWarning? ");
}
//
// Global exception handling
// thanks to: http://www.restoroot.com/Blog/2008/10/18/crash-reporter-for-iphone-applications/
//
/*
 void EX____uncaughtExceptionHandler(NSException *exception)
 {
 PolyLog(99,@"uncaughtExceptionHandler");
 
 
 //[AppManager showException:exception];
 exit(1);
 return;
 }
 */
- (void)view:(UIView*)aView moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         aView.frame = CGRectMake(destination.x,destination.y, aView.frame.size.width, aView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             [delegate performSelector:method];
                         }
                     }];
}
#define LOG_VIEW_PADDING_X 100
#define LOG_VIEW_WIDTH self.window.frame.size.width

-(void)attachLogView
{
#if !TARGET_IPHONE_SIMULATOR
    CGRect logFrame = CGRectMake(-LOG_VIEW_WIDTH + LOG_VIEW_PADDING_X, self.window.frame.size.height-200, LOG_VIEW_WIDTH , 200);
    self.logView = [[UITextView alloc] initWithFrame:logFrame];
    self.logView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8f];
    self.logView.textColor = [UIColor greenColor];
    self.logView.font = [UIFont systemFontOfSize:9];
    self.logView.editable = NO;
    [self redirectConsoleLogTo:self.logView];
    
    UISwipeGestureRecognizer * swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(logViewGestureHandler:)];
    [swipeLeftGestureRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
    [self.logView addGestureRecognizer:swipeLeftGestureRecognizer];
    RELEASE_OBJ(swipeLeftGestureRecognizer);
    
    UISwipeGestureRecognizer * swipeLRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(logViewGestureHandler:)];
    [swipeLRightGestureRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
    [self.logView addGestureRecognizer:swipeLRightGestureRecognizer];
    RELEASE_OBJ(swipeLRightGestureRecognizer);
    
    [self.window addSubview:self.logView];
    [self.window bringSubviewToFront:self.logView];
    
    //[self.window.rootViewController.view addSubview:self.logView];
    //[self.window.rootViewController.view bringSubviewToFront:self.logView];
    //self.logView.transform = CGAffineTransformMakeRotation(M_PI_2); // 90 degress
    
    RELEASE(self.logView);
#endif
    // RELEASE_OBJ(t);
}

-(void)logViewGestureHandler:(id)sender
{
    if([sender isKindOfClass:[UISwipeGestureRecognizer class]])
    {
        int direction =[((UISwipeGestureRecognizer*)sender) direction];
        if(direction == UISwipeGestureRecognizerDirectionRight){
            //show
            //[self.logView moveTo:CGPointMake(0, self.window.frame.size.height -200) duration:0.3f option:UIViewAnimationOptionCurveEaseOut delegate:nil callback:nil];
            [self view:self.logView moveTo:CGPointMake(0, self.window.frame.size.height -200) duration:0.3f option:UIViewAnimationOptionCurveEaseOut delegate:nil callback:nil];
        }else if(direction==UISwipeGestureRecognizerDirectionLeft){
            //hide
            //[self.logView moveTo:CGPointMake(-LOG_VIEW_WIDTH + LOG_VIEW_PADDING_X, self.window.frame.size.height -200) duration:0.3f option:UIViewAnimationOptionCurveEaseIn delegate:nil callback:nil];
            [self view:self.logView moveTo:CGPointMake(-LOG_VIEW_WIDTH + LOG_VIEW_PADDING_X, self.window.frame.size.height -200) duration:0.3f option:UIViewAnimationOptionCurveEaseIn delegate:nil callback:nil];
        }
    }
}
- (void) redirectConsoleLogTo:(UITextView*) logView
{
    
    /*
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
     NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"console.log"];
     freopen([logPath fileSystemRepresentation],"a+",stderr);
     */
    
    NSPipe* pipe = [NSPipe pipe];
    NSFileHandle* pipeReadHandle = [pipe fileHandleForReading];
    //dup2([[pipe fileHandleForWriting] fileDescriptor], fileno(stdout));
    dup2([[pipe fileHandleForWriting] fileDescriptor], fileno(stderr));
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, [pipeReadHandle fileDescriptor], 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_event_handler(source, ^{
        void* data = malloc(4096);
        ssize_t readResult = 0;
        do
        {
            errno = 0;
            readResult = read([pipeReadHandle fileDescriptor], data, 4096);
        } while (readResult == -1 && errno == EINTR);
        if (readResult > 0)
        {
            //AppKit UI should only be updated from the main thread
            dispatch_async(dispatch_get_main_queue(),^{
                NSString * stdOutString = [[NSString alloc] initWithBytesNoCopy:data length:readResult encoding:NSUTF8StringEncoding freeWhenDone:YES];
                NSString *logMessage = [NSString stringWithFormat:@"%@ \n----------\n",stdOutString];
                //[stdOutAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:[NSRange ]];
                //FIXED for ios6
                if([self.logView respondsToSelector:@selector(appendAttributedString:)]) {//if(IS_IOS7) {
                    
                    NSMutableAttributedString* stdOutAttributedString = [[NSMutableAttributedString alloc]initWithString:logMessage] ;
                    //
                    [stdOutAttributedString addColor:[UIColor greenColor] substring:stdOutString];
                    
                    
                    //[self.logView.textStorage appendAttributedString:stdOutAttributedString];
                    id stuff = [self.logView performSelector:@selector(textStorage)];
                    [stuff performSelector:@selector(appendAttributedString:) withObject:stdOutAttributedString];
                }
                else
                {
                    NSString * message = [NSString stringWithFormat:@"%@%@",self.logView.text, logMessage];
                    self.logView.text = message;
                }
                [self scrollLogViewToBottom];
                
            });
        }
        else{free(data);}
    });
    dispatch_resume(source);
    
}

-(void)scrollLogViewToBottom
{
    //    CGRect caretRect = [self.logView caretRectForPosition:self.logView.endOfDocument];
    //    [self.logView scrollRectToVisible:caretRect animated:NO];
    
    
    
    CGPoint p = [self.logView contentOffset];
    [self.logView setContentOffset:p animated:NO];
    [self.logView scrollRangeToVisible:NSMakeRange([self.logView.text length], 0)];
}
/*
 - (void)applicationWillResignActive:(UIApplication *)application
 {
 // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
 // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
 NSLog(@"applicationWillResignActive");
 }
 
 - (void)applicationDidEnterBackground:(UIApplication *)application
 {
 // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
 // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
 NSLog(@"applicationDidEnterBackground");
 }
 
 - (void)applicationWillEnterForeground:(UIApplication *)application
 {
 // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
 NSLog(@"applicationWillEnterForeground");
 }
 
 - (void)applicationDidBecomeActive:(UIApplication *)application
 {
 // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
 NSLog(@"applicationDidBecomeActive");
 }
 
 - (void)applicationWillTerminate:(UIApplication *)application
 {
 // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
 PolyLog(LOG_LEVEL_CUSTOM,@"applicationWillTerminate");
 }
 */




@end