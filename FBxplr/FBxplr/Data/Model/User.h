//
//  User.h
//  FBxplr
//
//  Created by andrea gonteri on 27/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCD.h"
#import "KVCUtils.h"



@interface User : UserCD


-(id)initWithDictionary:(NSDictionary*)dict;

@end
