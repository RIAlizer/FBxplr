//
//  Picture.h
//  FBxplr
//
//  Created by andrea gonteri on 22/01/14.
//  Copyright (c) 2014 rializer. All rights reserved.
//

#import "Picture.h"


@implementation Picture

@synthesize height;
@synthesize url;
@synthesize width;

@synthesize last_update;

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    NSParameterAssert(IsEmpty(dict));
    
    self = [super init];
    
    if(self)
    {
        
        
        self.url = [KVCUtils stringFrom:dict forKey:@"url"];
       // self.height = [KVCUtils numberFrom:dict forKey:@"height"];
        //self.width = [KVCUtils numberFrom:dict forKey:@"width"];
      
        
    }
    return self;
}



@end
