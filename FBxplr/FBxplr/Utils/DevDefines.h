//
//  DevDefines.h

//
//  Created by andrea gonteri on 2/10/12.
//  Copyright (c) 2012 Rializer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Logging.h"


/**
 * detect ARC features
 **/
#ifndef MB_STRONG
    #if __has_feature(objc_arc)
        #define MB_STRONG strong,nonatomic
    #else
        #define MB_STRONG retain, nonatomic
    #endif
#endif


#ifndef MB_ASSIGN
    #if __has_feature(objc_arc_weak)
        #define MB_ASSIGN  nonatomic
    #else
        #define MB_ASSIGN assign, nonatomic
    #endif
#endif

/*
#ifndef MB_WEAK
    #if __has_feature(objc_arc_weak)
        #define MB_WEAK weak
    #elseif __has_feature(objc_arc)
        #define MB_WEAK unsafe_unretained

    #endif
#endif
*/


/**
 * Release functions
 * check http://stackoverflow.com/questions/6778793/dealloc-method-in-ios-and-setting-objects-to-nil for more info
**/
#if __has_feature(objc_arc)
#define RELEASE_OBJ(x)
#else
#define RELEASE_OBJ(x) if(x!=nil){ [x release]; x = nil; } 
#endif

#if __has_feature(objc_arc)
#define RELEASE(x)
#else
#define RELEASE(x) if(x!=nil){[x release];}
#endif



#if __has_feature(objc_arc)
    #define AUTORELEASE(exp) exp
#else
    #define AUTORELEASE(exp) [exp autorelease]
#endif

#if __has_feature(objc_arc)
    #define SUPER_DEALLOC() ;
#else
    #define SUPER_DEALLOC() [super dealloc]
#endif

/**
 * Null objects
 **/
#define NULLME(x) x = nil


/**
 * Logging utility
 **/
#if DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#if DEBUG
#   define ALog(fmt, ...) LOG_FORMAT(fmt, @"trace", ##__VA_ARGS__)//(@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define ALog(...)
#endif


#if DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; RELEASE_OBJ(alert);}
#else
#   define ULog(...)
#endif

 
/**
 * Simplify NSLocalizedString
 **/
#if ENABLE_LOCALIZATION
#   define LSTR(str) NSLocalizedString(str,@"") 
#else
#   define LSTR(str)  str 
#endif

/**
 * Safe remove submviews
 **/
#define SAFE_REMOVE_SUBVIEWS(theView) for (int i=0; i<[theView.subviews count]; ++i){ if([[theView.subviews objectAtIndex:i] respondsToSelector:@selector(removeFromSuperview)])   [[theView.subviews objectAtIndex:i] removeFromSuperview];}



/**
 * Simplify Device Info
 **/
#define IS_IPAD  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

/**
 * Simplify NSLocalizedString
 **/
#define IS_RETINA  [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2



/**
 * Degrees to radians functions
 **/
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))


/**
 * check if NSArray, NSSet, NSString isEmpty
 **/
static inline BOOL IsEmpty(id thing)
{
    return thing == nil
   
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSSet *)thing count] == 0)
    || ([thing respondsToSelector:@selector(allKeys)]
        && [[thing allKeys] count]==0)
    || [thing isKindOfClass:[NSNull class]];// && [(NSArray *)thing count] == 0);
}

/**
 * interface orientation
 **/
#define INTERFACE_ORIENTATION_LANDSCAPEALL				((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight))
#define INTERFACE_ORIENTATION_LANDSCAPELEFT				(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
#define INTERFACE_ORIENTATION_LANDSCAPERIGHT			(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
#define INTERFACE_ORIENTATION_PORTRAITALL				((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
#define INTERFACE_ORIENTATION_PORTRAIT					(interfaceOrientation == UIInterfaceOrientationPortrait)
#define INTERFACE_ORIENTATION_PORTRAIT_UPSIDEDOWN		(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
#define INTERFACE_ORIENTATION_FREE

#define INTERFACE_ORIENTATION_IS_PORTRAIT  ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown)

#define IS_IOS7  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

#define STATUS_BAR_HEIGHT 20.0f