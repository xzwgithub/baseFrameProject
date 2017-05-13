//
//  NetworkCacheManager.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCacheConfig.h"

/**
 离线缓存组件
 依赖网络请求组件
 */



@interface NetworkCacheManager : NSObject



+ (NetworkCacheManager *)sharedManager;

/* 
 *
 *
 **/

- (NSString *)getRespWithURL:(NSString *)url requestBody:(NSString *)req;

- (void)putCacheWithURL:(NSString *)url
                  requestBody:(NSString *)req
                  requestTime:(long long)reqTime
                     response:(NSString *)resp
                 responseTime:(long long)respTime;


@end
