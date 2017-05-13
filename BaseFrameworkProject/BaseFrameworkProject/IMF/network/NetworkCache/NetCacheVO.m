//
//  NetCacheVO.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "NetCacheVO.h"
#import <objc/runtime.h>

@implementation NetCacheVO
@synthesize _id, url, req, reqTime, resp, respTime;

- (void)dealloc {
    
    ISS_RELEASE(url);
    ISS_RELEASE(req);
    ISS_RELEASE(resp);
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}


- (NSString *)toString {
    NSMutableString *returnString = [NSMutableString string];
    
    //获取所有的属性名称
    unsigned int propCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &propCount);
    for (i = 0; i < propCount; i++) {
        objc_property_t prop = properties[i];
        const char *propName = property_getName(prop);
        if(propName) {
            NSString *name = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            id tempValue = [self valueForKey:name];
            
            [returnString appendFormat:@"%@:%@, ",name, tempValue];
        }
    }
    free(properties);
    
    return [returnString substringToIndex:[returnString length]-1];
}


@end
