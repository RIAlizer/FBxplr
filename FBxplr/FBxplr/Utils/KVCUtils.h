//
//  KVCUtils.h
//  CoopShop
//
//  Created by andrea gonteri on 5/29/13.
//  Copyright (c) 2013 Andrea Gonteri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface KVCUtils : NSObject



+(NSDate*)dateFrom:(NSDictionary*)dictionary forKey:(NSString*)key;
+(NSString*)stringFrom:(NSDictionary*)dictionary forKey:(NSString*)key;
+(NSNumber*)numberFrom:(NSDictionary*)dictionary forKey:(NSString*)key;
+(NSInteger)integerFrom:(NSDictionary*)dictionary forKey:(NSString*)key;


+(void)map:(id)refObj fromDictionay:(NSDictionary*)sourceDict;
+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj;
+(NSArray*)getPropertiesFromClass:(Class)classObj;

@end
