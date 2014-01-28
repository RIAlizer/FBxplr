//
// ILBDataManager.m

//
//  Created by andrea gonteri on 28/02/14.
//  Copyright (c) 2014 Andrea Gonteri. All rights reserved.
//

#import "CoreDataManager.h"
#import "ISO8601DateFormatter.h"


@implementation CoreDataManager

#define DATABASE_FILENAME @"FBxplrDataManager.sqlite"

#pragma mark - Properties

@synthesize persistentStoreCoordinator =_persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

SYNTHESIZE_SINGLETON_FOR_CLASS(CoreDataManager);

#pragma mark - Object lifecycle

- (void)dealloc
{
    RELEASE_OBJ(_persistentStoreCoordinator);
    RELEASE_OBJ(_managedObjectContext);
    RELEASE_OBJ(_managedObjectModel);
    SUPER_DEALLOC();
}


#pragma mark - CoreData Utility
//Erase the persistent store from coordinator
- (void)flushDatabase
{
    
    NSPersistentStore *store = [ self.managedObjectContext.persistentStoreCoordinator.persistentStores lastObject];
    NSError *error = nil;
    NSURL *storeURL = store.URL;
    [ self.managedObjectContext.persistentStoreCoordinator removePersistentStore:store error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    
    if(![ self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        ULog(@"Database clear unexpected error ");
    }
    
    if (error)
    {
        ULog(@"Database clear error %@", [error localizedDescription]);
    }
    else
    {
        ULog(@"Local data erased succesfully");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DATABASE_CLEANEDUP object:nil];
    }
    
    
}

//non usato
//Featch database records
- (NSArray*)fetchEntitiesForName:(NSString*)entityName withPredicate:(NSPredicate*)predicate andSortDescriptor:(NSSortDescriptor*)sortDescriptor
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    [request setReturnsObjectsAsFaults:NO];
    
    [request setEntity:entity];
    // retrive the objects with a given value for a certain property
    //NSPredicate *predicate = [NSPredicate predicateWithFormat: @"uid == %@", uid];
    [request setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    // NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    @try
    {
        
        NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        [request release];
        
        [sortDescriptors release];
        
        BOOL exists = (result != nil) && ([result count]) && (error == nil);
        
        if (exists)
        {
            return result;
        }
        else
        {
            
            return nil;
            
        }
    }
    @catch (NSException *exception) {
        
        [AppManager showException:exception];
    }
    return nil;
}

#pragma mark - CoreData Methods
//
- (BOOL)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            ULog(@"Error during context save %@, %@", error,[error localizedDescription]);
            
            abort();
            return NO;
        }
        return YES;
    }
    return NO;
}

//Returns the managed object context for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    //    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"YKFileManager" withExtension:@"pkg"];
    //    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //_managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:DATABASE_FILENAME];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        ULog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

-(void)resetCoreDataComponents
{
    _persistentStoreCoordinator = nil;
    _managedObjectContext = nil;
    _managedObjectModel = nil;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



#pragma mark - Data

-(BOOL)saveUser:(User*)user
{
    
    NSParameterAssert(user);
    

    
    //check if exists
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"uid == %@ ", user.uid];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:NO];
    
    NSArray * result = [self fetchEntitiesForName:@"UserCD" withPredicate:predicate andSortDescriptor:sortDescriptor];
    RELEASE(sortDescriptor);
    ALog(@"predicate: %@",[predicate description]);
    BOOL exists = !IsEmpty(result);
    UserCD * userCD ;
    if(exists)
    {
         userCD = (UserCD*)[result lastObject];
        
        if([result count]>1)
        {
            LogError(@"Multiple User founded for %@",[predicate description]);
             return NO;
        }
       
    }
    else
    {
        ALog(@"adding new User...");
         userCD = (UserCD *) [NSEntityDescription insertNewObjectForEntityForName:@"UserCD" inManagedObjectContext:self.managedObjectContext];
     
      
        
    }
    
    if(!userCD){
        ULog(@"User not exist");
        return NO;
    }
    
    //mapping
    userCD.last_update = [NSDate date];
    userCD.uid = user.uid;
    userCD.first_name = user.first_name;
    userCD.username = user.username;
    userCD.last_name = user.last_name;
    userCD.name = user.name;
    userCD.birthday = user.birthday;
    userCD.middle_name = user.middle_name;
    userCD.link = user.link;
    
    
    BOOL success = [self saveContext];
    if(!success)
    {
        ULog(@"Unexpected Error during context save");
    }
    
    return success;
    
}

-(UserCD*)getUserWithUID:(NSString*)uid
{
    UserCD * userCD = nil;

    
    //check if exists
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"uid == %@ ", uid];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:NO];
    
    NSArray * result = [self fetchEntitiesForName:@"UserCD" withPredicate:predicate andSortDescriptor:sortDescriptor];
    RELEASE(sortDescriptor);
    ALog(@"predicate: %@",[predicate description]);
    BOOL exists = !IsEmpty(result);
   
    if(exists)
    {
        userCD = (UserCD*)[result lastObject];
        
        if([result count]>1)
        {
            LogError(@"Multiple User founded for %@",[predicate description]);
            return NO;
        }
        
    }
    
    
    return userCD;
}

/*
 //Featch database records
 - (void)fetchPresentations
 {
 
 NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDPresentation" inManagedObjectContext:self.managedObjectContext];
 
 //Setup the fetch request
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 [request setEntity:entity];
 
 //  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastName like %@) AND (birthday > %@)", lastNameSearchString, birthdaySearchDate];
 
 //apply sort
 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastUpdate" ascending:NO];
 NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
 [request setSortDescriptors:sortDescriptors];
 RELEASE(sortDescriptor );
 // Fetch the records and handle an error
 NSError *error = nil;
 NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
 if (error)
 {
 // Handle the error.
 // This is a serious error and should advise the user to restart the application
 ULog(@"ERROR during fetchRecords %@", [error localizedDescription]);
 }
 // Save our fetched data to an array
 [[VTAppManager sharedInstance] setStoredPresentationList:mutableFetchResults];
 
 RELEASE(mutableFetchResults);
 RELEASE(request);
 }
 */

@end
