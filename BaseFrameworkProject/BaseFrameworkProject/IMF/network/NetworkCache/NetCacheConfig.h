//
//  NetCacheConfig.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISSARC.h"


@interface NetCacheConfig : NSObject


/*
 *  缓存的url与时间的键值对 如:@{URL_REPORT_STATUS: @(15 * 60 * 1000)}   单位是毫秒数
 *  默认最大缓存条数是1000条
 *  使用提示 可在BaseBiz中做设置
 **/

+ (void)setCacheConfig:(id)config cacheMaxNumber:(long)maxNum;

+ (long)getCacheConfigByURL:(NSString *)url;

+ (long)cacheMaxNum;


@end
