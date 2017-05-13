//
//  NetworkCacheManager.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "NetworkCacheManager.h"
#import "NetCacheDao.h"
#import "NetCacheVO.h"
#import "NetCacheConfig.h"


@implementation NetworkCacheManager

static NetworkCacheManager *sharedAccountManagerInstance = nil;


- (void) operation
{
    // do something
    NSLog(@"Singleton");
}

+ (NetworkCacheManager *)sharedManager
{
#if ! __has_feature(objc_arc)

    if (sharedAccountManagerInstance == nil)
    {
        sharedAccountManagerInstance = [[self alloc] init];
    }
    return sharedAccountManagerInstance;
#else
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
#endif
    
}

#if ! __has_feature(objc_arc)

+ (id) allocWithZone:(NSZone *)zone
{
    return ISS_RETAIN([self sharedManager]);
}


- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax; // denotes an object that cannot be released
}

- (oneway void) release
{
    // do nothing
}

- (id) autorelease
{
    return self;
}
#endif



- (NSString *)getRespWithURL:(NSString *)url requestBody:(NSString *)req {
    
    if([NetCacheConfig getCacheConfigByURL:url] == 0l){
        NSLog(@"url = %@ 配置不需要缓存，直接return", url);
        return nil;
    }
    
    NetCacheDao *dao = [[NetCacheDao alloc] init];
    NetCacheVO *entity = [[NetCacheVO alloc] init];
    entity.url = url;
    entity.req = req;
    
    NSArray *cachedArray = [dao queryWithEntity:entity];
    if ([cachedArray count]>0) {
        NSLog(@"查询到缓存: %@", [entity toString]);
        
        NetCacheVO *cache = [cachedArray objectAtIndex:0];
        
        // 在有效时间内，才采用
        long long currentTimeMillis = [[NSDate date] timeIntervalSince1970]*1000;
        if (currentTimeMillis - cache.respTime < [NetCacheConfig getCacheConfigByURL:url]) {
            return cache.resp;
        }else{
            NSLog(@"缓存已过期， 不再使用");
        }
    }
    ISS_RELEASE(dao);
    ISS_RELEASE(entity);
    
    return nil;
}



- (void)putCacheWithURL:(NSString *)url
                  requestBody:(NSString *)req
                  requestTime:(long long)reqTime
                     response:(NSString *)resp
                 responseTime:(long long)respTime {
    if([NetCacheConfig getCacheConfigByURL:url] == 0l){
        NSLog(@"url = %@ 配置不需要缓存，直接return", url);
        return;
    }
    
    NetCacheVO *entity = [[NetCacheVO alloc] init];
    entity.url = url;
    entity.req = req;
    entity.reqTime = reqTime;
    entity.resp = resp;
    entity.respTime = respTime;
    
    NetCacheDao *dao = [[NetCacheDao alloc] init];

    NSArray *cachedArray = [dao queryWithEntity:entity];
    
    if ([cachedArray count]>0) {
        entity._id = [(NetCacheVO *)cachedArray[0] _id];
        NSLog(@"已经缓存过，做更新操作: %@", [entity toString]);
        [dao updateWithEntity:entity];
    }
    else {
        NSLog(@"还未缓存过，做插入操作: %@", [entity toString]);
        [dao insertWithEntity:entity];
    }
    
    
    // 清除超出数量的缓存
    cachedArray = [dao queryWithEntity:entity];
    if ([cachedArray count]>NetCacheConfig.cacheMaxNum) {
        NSLog(@"缓存条数超过最大允许数：%ld，需要做删除操作",NetCacheConfig.cacheMaxNum);
        
        for (int i=NetCacheConfig.cacheMaxNum; i<[cachedArray count]; i++) {
            NetCacheVO *obj = [cachedArray objectAtIndex:i];
            [dao deleteWithEntity:obj];
        }
    }
    
    ISS_RELEASE(dao);
    ISS_RELEASE(entity);


}

@end
