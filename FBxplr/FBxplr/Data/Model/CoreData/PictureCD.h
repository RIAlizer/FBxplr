//
//  PictureCD.h
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PictureCD : NSManagedObject

@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSDate * last_update;
@end
