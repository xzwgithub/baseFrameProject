//
//  CrashLog.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-10-14.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "CrashLog.h"
#import <objc/runtime.h>

@implementation CrashLog

@synthesize when, content, type;

//- (void)dealloc {
//    
////    [content release];
//    
//    [super dealloc];
//}



- (NSDictionary *)toDictionary {
    
    NSMutableDictionary *returnDic = [[NSMutableDictionary alloc] init];
    
    //获取所有的属性名称
    unsigned int propCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &propCount);
    for (i = 0; i < propCount; i++) {
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName) {
            NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            id tempValue = [self valueForKey:name];
            //            if (!tempValue || tempValue == [NSNull null]) {//增加为空的判断。附上默认值
            //                    tempValue = @"";
            //            }
            //            [returnDic setValue:[self valueForKey:name] forKey:name];//从类里面取值然后赋给每个值，取得字典
            [returnDic setValue:tempValue forKey:name];
        }
    }
    free(properties);
    
    return returnDic;
    
}


- (NSString *)toJsonStr {
    NSDictionary *dictionary = [self toDictionary];
    id data =[NSJSONSerialization dataWithJSONObject:dictionary
                                             options:NSJSONWritingPrettyPrinted
                                               error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
