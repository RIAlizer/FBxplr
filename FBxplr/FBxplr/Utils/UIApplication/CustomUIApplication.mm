
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

@end