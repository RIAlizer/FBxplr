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



-(id)initWithDictionary:(NSDictionary*)dict
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



@end
