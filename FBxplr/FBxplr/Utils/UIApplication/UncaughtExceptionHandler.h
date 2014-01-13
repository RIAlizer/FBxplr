//
//  UncaughtExceptionHandler.h
//  UncaughtExceptions
//
//  Created by Matt Gallagher on 2010/05/25.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//http://iosabraham.blogspot.it/2012/05/exception-handling-in-objective-c.html

//http://www.cocoawithlove.com/2010/05/handling-unhandled-exceptions-and.html


#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject
{
	BOOL dismissed;
}

@end

void InstallUncaughtExceptionHandler();
