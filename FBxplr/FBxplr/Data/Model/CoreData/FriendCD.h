//
//  FriendCD.h
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PictureCD.h"

@interface FriendCD : NSManagedObject

@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) PictureCD *pictureFriend;
@property (nonatomic, retain) NSDate * last_update;
@end
