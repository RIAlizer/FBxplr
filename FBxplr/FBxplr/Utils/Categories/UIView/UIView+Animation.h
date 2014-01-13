//
//  UIView+Animation.h
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

float radiansForDegrees(int degrees);

@interface UIView (Animation)

//fade
-(void)fadeInWithDuration:(float)duration;
-(void)fadeInWithDuration:(float)duration completion:(void (^)(BOOL finished))completion;
-(void)fadeOutWithDuration:(float)duration;
-(void)fadeOutWithDuration:(float)duration andFadeInDuration:(float)fadeInDuration;
// Moves
-(void)moveMeRandomly;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;

// Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

// Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

// Effects
-(void)changeAlpha:(float)newAlpha secs:(float)secs;
-(void)pulse:(float)secs continuously:(BOOL)continuously;

@end
