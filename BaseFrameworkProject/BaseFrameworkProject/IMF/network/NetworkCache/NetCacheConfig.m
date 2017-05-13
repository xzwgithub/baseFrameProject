//
//  NetCacheConfig.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "NetCacheConfig.h"

@implementation NetCacheConfig


/**
 * 允许的网络缓存的最大条数
 */
static int NET_CACHE_MAX_NUM = 1000;

static NSDictionary *cacheConfig = nil;

+ (void)initialize {
    
    cacheConfig = @{
//                    URL_REPORT_STATUS: @(15 * 60 * 1000),
//                    URL_COURSE_GETSCHEDULE : @(2 * 60 * 1000),
//                    URL_PUB_GETTEACHERCOURSES: @(2 * 60 * 1000)
                    };
    ISS_RETAIN(cacheConfig);
}

+ (long)getCacheConfigByURL:(NSString *)url {

//    if (cacheConfig) {
//        CFShow(cacheConfig);
//    }
    id effectiveDuration = cacheConfig[url];
    
    if (effectiveDuration == nil) {
        return 0l;
    }
    NSLog(@"URL失效时间:%ld", [effectiveDuration longValue]);

    return [effectiveDuration longValue];
}

+ (long)cacheMaxNum {
    return NET_CACHE_MAX_NUM;
}


+ (void)setCacheConfig:(id)config cacheMaxNumber:(long)maxNum {
    cacheConfig = [NSDictionary dictionaryWithDictionary:config];
    NET_CACHE_MAX_NUM = (int)maxNum;
}


@end
