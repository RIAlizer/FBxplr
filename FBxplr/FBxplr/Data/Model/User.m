//
//  User.m
//  FBxplr
//
//  Created by andrea gonteri on 27/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "User.h"



@implementation User

@synthesize name;
@synthesize birthday;
@synthesize first_name;
@synthesize last_name;
@synthesize middle_name;
@synthesize uid;
@synthesize username;
@synthesize link;

@synthesize last_update;

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    NSParameterAssert(IsEmpty(dict));
    
    self = [super init];
    
    if(self)
    {
        
        self.uid = [KVCUtils stringFrom:dict forKey:@"id"];
        self.name = [KVCUtils stringFrom:dict forKey:@"name"];
        self.birthday = [KVCUtils stringFrom:dict forKey:@"birthday"];
        self.first_name = [KVCUtils stringFrom:dict forKey:@"first_name"];
        self.last_name = [KVCUtils stringFrom:dict forKey:@"last_name"];
        self.middle_name = [KVCUtils stringFrom:dict forKey:@"middle_name"];
        self.username = [KVCUtils stringFrom:dict forKey:@"username"];
        self.link = [KVCUtils stringFrom:dict forKey:@"link"];
        
        

       
    }
    return self;
}
- (instancetype)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy) {
         //[copy setMediaName:AUTORELEASE([self.mediaName copyWithZone:zone])];
        [copy setUid:AUTORELEASE([self.uid copyWithZone:zone])];
        [copy setName:AUTORELEASE([self.name copyWithZone:zone])];
        [copy setFirst_name:AUTORELEASE([self.first_name copyWithZone:zone])];
        [copy setFirst_name:AUTORELEASE([self.last_name copyWithZone:zone])];
        [copy setUsername:AUTORELEASE([self.username copyWithZone:zone])];
        [copy setMiddle_name:AUTORELEASE([self.middle_name copyWithZone:zone])];
        [copy setLink:AUTORELEASE([self.link copyWithZone:zone])];
        [copy setBirthday:AUTORELEASE([self.link copyWithZone:zone])];
        
        
    }
     return copy;
    
}


@end
