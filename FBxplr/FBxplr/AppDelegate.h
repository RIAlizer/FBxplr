//
//  AppDelegate.h
//  FBxplr
//
//  Created by andrea gonteri on 13/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUIApplication.h"

@interface AppDelegate : CustomUIApplication

@property (MB_STRONG) UIWindow *window;

@property (readonly, MB_STRONG) NSManagedObjectContext *managedObjectContext;
@property (readonly, MB_STRONG) NSManagedObjectModel *managedObjectModel;
@property (readonly, MB_STRONG) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
