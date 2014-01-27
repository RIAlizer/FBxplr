//
//  UserCD.h
//  FBxplr
//
//  Created by andrea gonteri on 27/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserCD : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * middle_name;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * birthday;

@end
