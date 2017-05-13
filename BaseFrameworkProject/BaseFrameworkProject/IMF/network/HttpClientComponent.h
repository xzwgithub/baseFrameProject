//
//  HttpClientComponent.h
//  UniversalArchitecture
//
//  Created by issuser on 12-10-29.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCFileConfig.h"
#import "NetworkCacheManager.h"


typedef NS_ENUM(NSInteger, MMHTTPContentType) {
    MMHTTPContentTypeApplicationJson = 0,       //json, 默认
    MMHTTPContentTypeTextPlain,                 //普通文本，Content-Type="text/plain"
    MMHTTPContentTypeTextHtml,                  //HTML代码，Content-Type="text/html"
    MMHTTPContentTypeTextXml,                   //XML代码，Content-Type="text/xml"
    MMHTTPContentTypeApplicationJavascript,     //javascript，Content-Type="application/javascript"
    MMHTTPContentTypeApplicationFormUrlencoded  //窗体数据被编码为名称/值对, application/x-www-form-urlencoded
};


/*
 * 无网络连接时返回的
 */
#define MMCNetworkErrorCode        256
#define MMCNetworkErrorMessage     @"网络连接失败，请检查网络！"

/**
 请求成功block
 */
typedef void (^requestSuccessBlock)(NSDictionary *responseDictionary);
/**
 请求失败block
 */
typedef void (^requestFailureBlock)(NSError *error);
/**
 请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);
/**
 监听进度响应block
 */
typedef void (^progressBlock)(int64_t bytesWritten,
                              int64_t totalBytesWritten,
                              int64_t totalBytesExpectedToWrite);


/**
 *  网络请求组件，适合软通风格接口调用，提供成功与失败的回调block
 *  提供简单的上传下载操作
 *  可设置url请求缓存时长及缓存最大条数，在时长范围内会使用缓存数据，而不进行接口调用，如：
 15分钟都使用缓存，缓存最大条数为1000
 NSDictionary * cacheConfig = @{
                                @"http://url1" : @(15 * 60 * 1000),
                                @"http://url2" : @(15 * 60 * 1000)
                                };
 
 [[MMNetworkCache sharedNetworkCache] setCacheConfig:^NSDictionary *{
    return cacheConfig;
 } cacheMaxNumber:^long{
    return 1000;
 }];

 *
 *
 */
@interface HttpClientComponent : NSObject


/**
 *  请求响应原始数据
 */
@property (nonatomic, strong) NSData *responseData;
/**
 *  请求响应字符串
 */
@property (nonatomic, strong) NSString *responseString;
/**
 *  请求响应字典
 */
@property (nonatomic, strong) NSDictionary *responseDictionary;
/**
 *  当前错误
 */
@property (nonatomic, strong) NSError *error;


/**
 * 设置请求超时时间，单位：秒
 * 使用提示：此方法连同设置url缓存时长，设置通用参数一致，可放在BaseBiz中做设置
 *
 *  @param timeoutInterval 超时时间
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)timeoutInterval;


/**
 * 设置是否使用缓存，设为 NO 时强制请求网络
 *
 *  @param use 是否使用缓存
 */
- (void)setUseCache:(BOOL)use;

/**
 * 添加http请求头
 *
 *  @param dictionary 需要添加的额外请求头字典
 */
- (void)addHTTPHeaderFields:(NSDictionary *)dictionary;


/**
 *  /
 * 接受类型不一致使用，需要设置，如：text/html、text/xml或application/javascript
 *
 *  @param contentType MMHTTPContentType枚举值
 */
- (void)setAcceptableContentType:(MMHTTPContentType)contentType;


/**
 * 发送GET请求
 *
 *  @param url            网络请求地址
 *  @param params         请求消息字典，无须转换为json，未设置黑名单的接口会自动加上统一包体
 *  @param successHandler 请求成功回调
 *  @param failureHandler 请求失败回调
 */
- (void)sendGETRequestWithUrl:(NSString *)url
                       params:(NSDictionary *)params
                      success:(requestSuccessBlock)successHandler
                      failure:(requestFailureBlock)failureHandler;


/**
 * 发送POST请求
 *
 *  @param url            网络请求地址
 *  @param params         请求消息字典，无须转换为json，未设置黑名单的接口会自动加上统一包体
 *  @param successHandler 请求成功回调
 *  @param failureHandler 请求失败回调
 */
- (void)sendPOSTRequestWithUrl:(NSString *)url
                        params:(NSDictionary *)params
                       success:(requestSuccessBlock)successHandler
                       failure:(requestFailureBlock)failureHandler;


/**
 * 下载文件，监听下载进度
 *
 *  @param url               下载请求地址
 *  @param progressHandler   进度回调
 *  @param completionHandler 完成回调，回调参数中有dataObj为下载存放路径的URL
 */
- (void)downloadRequestWithUrl:(NSString *)url
                      progress:(progressBlock)progressHandler
             completionHandler:(responseBlock)completionHandler;

/**
 * 上传文件，监听上传进度
 *
 *  @param url               上传请求地址
 *  @param params            参数
 *  @param fileConfig        上传文件配置对象MMFileConfig实例
 *  @param progressHandler   进度回调
 *  @param completionHandler 上传完成回调
 */
- (void)uploadRequestWithUrl:(NSString *)url
                      params:(NSDictionary *)params
                  fileConfig:(HCFileConfig *)fileConfig
                    progress:(progressBlock)progressHandler
           completionHandler:(responseBlock)completionHandler;



/**
 *
 * 设置通用参数,含通用参数的key的字典，如：@{@"commonParam":@{...}}, @{@"deviceInfo":@{...}}
 * 以及请用时不用通用参数请求的黑名单，如登录及获取验证不需要参数，需调用此方法设置
 * 使用提示：此方法连同设置url缓存时长，可放在BaseBiz中做设置
 *
 *
 *  @param commonParam 通用参数字典
 *  @param array       无需使用通用参数的黑名单数组
 */
+ (void)setCommonParam:(NSDictionary *)commonParam notUsedUrlBlackList:(NSArray *)array;

/**
 *
 * 获取通用参数
 *
 *  @return 通用参数字典
 */
+ (NSDictionary *)commonParam;

/**
 *
 * 更新通用参数，使用场景：如切换用户需要更新。
 *
 *  @param commonParam 通用参数字典
 */
+ (void)updateCommonParam:(NSDictionary *)commonParam;


@end

