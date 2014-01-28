//
//  CoreDataManager.h
 
//
//  Created by andrea gonteri on 28/02/13.
//  Copyright (c) 2014 Andrea Gonteri. All rights reserved.
//


#import "SingletonHelper.h"

#import "User.h"
#import "UserCD.h"
#import "FriendCD.h"
#import "PictureCD.h"


/**
 `CoreDataManager` is a singleton class that manage CoreData persisting behaviour.
 */

#define DATABASE_CLEANEDUP @"DATABASE_CLEANEDUP"

@interface CoreDataManager : NSObject
{

    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;
}


@property (MB_STRONG) NSPersistentStoreCoordinator * persistentStoreCoordinator;
@property (MB_STRONG) NSManagedObjectModel * managedObjectModel;
@property (MB_STRONG) NSManagedObjectContext * managedObjectContext;

///--------------
/// @name Class Methods
///--------------

/**
 Shared instance
 
 Return a singleton `CoreDataManager`
 */

+ (CoreDataManager *)sharedInstance;

-(void)flushDatabase;

- (BOOL)saveContext;

-(void)resetCoreDataComponents;


-(BOOL)saveUser:(User*)user;
-(UserCD*)getUserWithUID:(NSString*)uid;
-(void)mapUser:(User*)user fromUserCD:(UserCD*)userCD;
-(void)mapUserCD:(UserCD*)userCD fromUserCD:(User*)user;
@end
