//
//  Friend.m
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "Friend.h"
#import "Picture.h"


@implementation Friend

@synthesize bio;
@synthesize birthday;
@synthesize gender;
@synthesize link;
@synthesize name;
@synthesize uid;
@synthesize pictureFriend;
 


-(id)initWithDictionary:(NSDictionary*)dict
{
    
    
    self = [super init];
    
    if(self)
    {
        
        self.uid = [KVCUtils stringFrom:dict forKey:@"id"];
        self.bio = [KVCUtils stringFrom:dict forKey:@"bio"];
        //self.birthday = [KVCUtils stringFrom:dict forKey:@"birthday"];
        self.gender = [KVCUtils stringFrom:dict forKey:@"gender"];
        self.link = [KVCUtils stringFrom:dict forKey:@"link"];
        self.name = [KVCUtils stringFrom:dict forKey:@"name"];
        
        NSDictionary * pictureDict = [dict objectForKey:@"picture"];
        if(!IsEmpty(pictureDict))
            self.pictureFriend = [[Picture alloc] initWithDictionary:[pictureDict objectForKey:@"data"]];

       
    }
    return self;
}



@end
