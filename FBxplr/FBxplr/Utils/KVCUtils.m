//
//  KVCUtils.m
//  CoopShop
//
//  Created by andrea gonteri on 5/29/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import "KVCUtils.h"
#import "NSDate+Helper.h"

@implementation KVCUtils


+(NSDate*)dateFrom:(NSDictionary*)dictionary forKey:(NSString*)key
{
    NSDate* retval =nil;
    
    if([dictionary objectForKey:key]){
        id value = [dictionary objectForKey:key];
        if(!IsEmpty(value))
            retval = [NSDate dateFromString:value];
        
    }
    return retval;
}
+(NSString*)stringFrom:(NSDictionary*)dictionary forKey:(NSString*)key
{
    NSString* retval =nil;
    if([dictionary objectForKey:key]){
        id value = [dictionary objectForKey:key];
        if(!IsEmpty(value))
            retval = [NSString stringWithString:value];
        
    }
    return retval;
}

+(NSNumber*)numberFrom:(NSDictionary*)dictionary forKey:(NSString*)key
{
    NSNumber* retval =nil;
    if([dictionary objectForKey:key]){
        id value = [dictionary objectForKey:key];
        if(!IsEmpty(value))
            retval = [NSNumber numberWithInteger:[[NSString stringWithString:value] integerValue]];
        
    }
    return retval;
}

+(NSInteger)integerFrom:(NSDictionary*)dictionary forKey:(NSString*)key
{
    NSInteger retval = 0;
    if([dictionary objectForKey:key]){
        id value = [dictionary objectForKey:key];
        if(!IsEmpty(value))
            retval = (int)value;
            
    }
    return retval;
}

+(void)map:(id)refObj fromDictionay:(NSDictionary*)sourceDict
{
    
   // NSLog(@"%@", [self autoDescribe:refObj]);
  
    unsigned pcount;
//    objc_property_t *p = class_copyPropertyList([refObj class], &pcount);
    NSArray * properties = [self getPropertiesFromClass:[refObj class]];
    
   // NSArray * properties = [refObj propertyNames];
    int count = [properties count];
    for (int i = 0; i < count; i++) {
        //NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        //[dict setObject:[obj valueForKey:key] forKey:key];
        NSString *key = properties[i];
        
        id val = [sourceDict objectForKey:key];
        
        if(!IsEmpty(val)){
            [refObj setObject:val forKey:key];
        }
        else
        {
               const char * propType= [refObj typeOfPropertyNamed:key];
            
        }
        
    }
    
    free(properties);
    
}

// Finds all properties of an object, and prints each one out as part of a string describing the class.
+ (NSString *) autoDescribe:(id)instance classType:(Class)classType
{
    NSUInteger count;
    objc_property_t *propList = class_copyPropertyList(classType, &count);
    NSMutableString *propPrint = [NSMutableString string];
    
    for ( int i = 0; i < count; i++ )
    {
        objc_property_t property = propList[i];
        
        const char *propName = property_getName(property);
        NSString *propNameString =[NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
        
        if(propName)
        {
            id value = [instance valueForKey:propNameString];
            [propPrint appendString:[NSString stringWithFormat:@"%@=%@ ; ", propNameString, value]];
        }
    }
    free(propList);
  
    
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass( classType );
    if ( superClass != nil && ! [superClass isEqual:[NSObject class]] )
    {
        NSString *superString = [self autoDescribe:instance classType:superClass];
        [propPrint appendString:superString];
    }
    
    return propPrint;
}

+ (NSString *) autoDescribe:(id)instance
{
    NSString *headerString = [NSString stringWithFormat:@"%@:%p:: ",[instance class], instance];
    return [headerString stringByAppendingString:[self autoDescribe:instance classType:[instance class]]];
}

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[obj valueForKey:key] forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

+(NSArray*)getPropertiesFromClass:(Class)classObj
{
    NSMutableArray * propertyArray = [NSMutableArray array];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(classObj, &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];

        [propertyArray addObject:key];
    }
    
    free(properties);
    
    return propertyArray;
    
}
@end
