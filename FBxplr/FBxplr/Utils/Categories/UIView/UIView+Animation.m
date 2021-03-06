//
//  UIView+Animation.m
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+Animation.h"


// Very helpful function

float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180;
}


@implementation UIView (Animation)


//fade
-(void)fadeInWithDuration:(float)duration completion:(void (^)(BOOL finished))completion{
    self.alpha = 0.0f;
    
    
    [UIView animateWithDuration:duration
                     animations:^{
                         if(self)
                             self.alpha = 1.0f;
                     } completion:^(BOOL finished){
                         
                         if(completion){
                             completion(finished);
                         }
                         ALog(@"end animation");
                         
                         
                     }];
    
}
//fade
-(void)fadeInWithDuration:(float)duration
{
    
    [self fadeInWithDuration:duration completion:nil];
    
}

-(void)fadeOutWithDuration:(float)duration
{
    
    //    self.alpha = 0.0f;
    //    return;
    
    self.alpha = 1.0f;
    
    
    
    [UIView animateWithDuration:duration
                     animations:^{
                         if(self)
                             self.alpha = 0.0f;
                     } completion:^(BOOL finished){
                         ALog(@"end animation");
                     }];
}

-(void)fadeOutWithDuration:(float)duration andFadeInDuration:(float)fadeInDuration
{
    self.alpha = 1.0f;
    
    
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.alpha = 0.0f;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:fadeInDuration
                                          animations:^{
                                              self.alpha = 1.0f;
                                          } completion:^(BOOL finished){
                                              ALog(@"end animation");
                                          }];
                     }];
}

#pragma mark - Moves


-(void)moveMeRandomly
{
    [self animationLoop:@"radnom" finished:3 context:nil];
}
-(void)animationLoop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:5];
    // remove:
    //  [UIView setAnimationRepeatCount:1000];
    //  [UIView setAnimationRepeatAutoreverses:YES];
    
    CGFloat x = (CGFloat) (arc4random() % (int) self.superview.bounds.size.width);
    CGFloat y = (CGFloat) (arc4random() % (int) self.superview.bounds.size.height);
    
    CGPoint squarePostion = CGPointMake(x, y);
    self.center = squarePostion;
    // add:
    [UIView setAnimationDelegate:self]; // as suggested by @Carl Veazey in a comment
    [UIView setAnimationDidStopSelector:@selector(animationLoop:finished:context:)];
    
    [UIView commitAnimations];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             [delegate performSelector:method];
                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.2
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:nil];
                         }
                     }];
}


#pragma mark - Transforms

- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             [delegate performSelector:method];
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             [delegate performSelector:method];
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}


#pragma mark - Transitions

- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
	NSTimer *timer;
    self.tag = 20;
	timer = [NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
	CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
	self.transform = trans;
	self.alpha = self.alpha * 0.98;
	self.tag = self.tag - 1;
	if (self.tag <= 0) {
		[timer invalidate];
		[self removeFromSuperview];
	}
}

#pragma mark - Effects

-(void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

-(void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:secs/2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}


@end
