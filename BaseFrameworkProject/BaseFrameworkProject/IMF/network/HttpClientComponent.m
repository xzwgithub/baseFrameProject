//
//  HttpClientComponent.m
//  UniversalArchitecture
//
//  Created by issuser on 12-10-29.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import "HttpClientComponent.h"
#import <netinet/in.h>
#import <AFNetworking/AFNetworking.h>
#import "ISSMacros.h"
#import "Utils.h"

@interface HttpClientComponent() {
    BOOL useCache;
    BOOL useNetTraffic;

    AFHTTPSessionManager *sessionManager;
}

@property (assign) id callbackTarget;
@property (assign) SEL failedSelector;
@property (nonatomic, strong) NSTimer *timeoutTimer;

@end

static NSTimeInterval requsetTimeOutSeconds = 100;
static NSArray *urlBlackList = nil;

@implementation HttpClientComponent

- (void)dealloc {

    sessionManager = nil;
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer.timeoutInterval = requsetTimeOutSeconds;
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil]];
        
        //默认不使用缓存
        useCache = NO;
        //默认不统计流量
        useNetTraffic = NO;
    }
    return self;
}

- (void)addHTTPHeaderFields:(NSDictionary *)dictionary {
    NSArray *keys = dictionary.allKeys;
    for (NSString *k in keys) {
        [sessionManager.requestSerializer setValue:dictionary[k]
                                forHTTPHeaderField:k];
    }
}

- (void)setAcceptableContentType:(MMHTTPContentType)contentType {
    
    NSString *contentTypeString = nil;
    switch (contentType) {
        case MMHTTPContentTypeApplicationJson:
            contentTypeString = @"application/json";
            break;
        case MMHTTPContentTypeTextPlain:
            contentTypeString = @"text/plain";
            break;
        case MMHTTPContentTypeTextHtml:
            contentTypeString = @"text/html";
            break;
        case MMHTTPContentTypeTextXml:
            contentTypeString = @"text/xml";
            break;
        case MMHTTPContentTypeApplicationJavascript:
            contentTypeString = @"application/javascript";
            break;
        case MMHTTPContentTypeApplicationFormUrlencoded:
            contentTypeString = @"application/x-www-form-urlencoded";
            break;
        default:
            contentTypeString = @"application/json";
            break;
    }
    
    sessionManager.responseSerializer.acceptableContentTypes = [sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"]; //[NSSet setWithObject:contentTypeString];
}

+ (void)setCommonParam:(NSDictionary *)commonParam notUsedUrlBlackList:(NSArray *)array {
    [[self class] updateCommonParam:commonParam];
    urlBlackList = [NSArray arrayWithArray:array];
}


+ (NSDictionary *)commonParam {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults objectForKey:@"commonParam"];

    return dict;
}

+ (void)updateCommonParam:(NSDictionary *)commonParam {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:commonParam forKey:@"commonParam"];
    NSLog(@"公共参数：%@",commonParam);
    [defaults synchronize];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)timeoutInterval {
    requsetTimeOutSeconds = timeoutInterval;
}


- (void)setUseCache:(BOOL)use {
    useCache = use;
}

- (void)setUseNetTraffic:(BOOL)use{
    useNetTraffic = use;
}

- (void)sendGETRequestWithUrl:(NSString *)url
                       params:(NSDictionary *)params
                      success:(requestSuccessBlock)successHandler
                      failure:(requestFailureBlock)failureHandler {
    NSLog(@"get request url=%@",url);
    NSString *body = @"";
    
    if (params != nil) {
        id jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        body = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        //是否拿缓存
    }
    //是否拿缓存
    if (useCache) {
        // 获取缓存数据
        NSString *result = [[NetworkCacheManager sharedManager] getRespWithURL:url requestBody:body];
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
        if (nil != result) {
            NSLog(@"post response url=%@; 采用缓存数据， response:%@",url,result);
            self.responseString = result;
            if (successHandler) {
                successHandler(jsonObject);
            }
            return;
        }
    }
    
    if (![self networkReachable]) {
        self.error = [NSError errorWithDomain:MMCNetworkErrorMessage code:MMCNetworkErrorCode userInfo:nil];
        if (failureHandler) {
            failureHandler(self.error);
        }
        return;
    }
    

    long long reqTime = [[NSDate date] timeIntervalSince1970]*1000;
    
    __block HttpClientComponent *component = self;
    sessionManager.requestSerializer.timeoutInterval = requsetTimeOutSeconds;
    
    [sessionManager GET:url parameters:params progress:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    component.responseDictionary = responseObject;
                    
                    NSError *error;
                    component.responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
                    NSLog(@"responseData原始长度:%lu",(unsigned long)[component.responseData length]);
                    component.responseString =[[NSString alloc] initWithData:component.responseData encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"\nresponse url:%@ \nresponse:%@",url, component.responseString);
                    //请求成功记录到缓存
                    long long respTime = [[NSDate date] timeIntervalSince1970]*1000;
                    [[NetworkCacheManager sharedManager] putCacheWithURL:url
                                                             requestBody:body
                                                             requestTime:reqTime
                                                                response:component.responseString
                                                            responseTime:respTime];
                    
                    if (successHandler) {
                        successHandler(component.responseDictionary);
                    }
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"------请求失败-------%@",error);
                    component.error = error;
                    failureHandler(error);
                }];
}

/**
 * 发送post请求
 *
 * @param url
 *            请求的网络地址
 * @param params
 *            请求消息字典，无须转换为json，会自动加上统一包体
 * @param successHandler
 *            请求成功回调
 * @param failureHandler
 *            请求失败回调
 */
- (void)sendPOSTRequestWithUrl:(NSString *)url
                        params:(NSDictionary *)params
                       success:(requestSuccessBlock)successHandler
                       failure:(requestFailureBlock)failureHandler {
    if (![self networkReachable]) {
        self.error = [NSError errorWithDomain:MMCNetworkErrorMessage code:MMCNetworkErrorCode userInfo:nil];
        if (failureHandler) {
            failureHandler(self.error);
        }
        return;
    }
    
    NSMutableDictionary *bodyDictionary = nil;
    NSString *body = @"";

    if (params != nil) {
        bodyDictionary = [NSMutableDictionary dictionaryWithDictionary:params];
        id jsondata = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        body = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        //是否拿缓存
    }
    
    
    //登录和获取验证码的时候不用传通用参数
    if (![urlBlackList containsObject:url]) {
        if (bodyDictionary == nil) {
            bodyDictionary = [NSMutableDictionary dictionary];
        }
        [bodyDictionary addEntriesFromDictionary:[[self class] commonParam]];
    }
    
    if (useCache) {
        NetworkCacheManager *netCacheManager = [NetworkCacheManager sharedManager];
        
        // 获取缓存数据
        NSString *result = [netCacheManager getRespWithURL:url requestBody:body];
        
        if (nil != result) {
            NSLog(@"post response url=%@; 采用缓存数据， response:%@",url,result);
            self.responseString = result;
            NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            if (successHandler) {
                successHandler(dic);
            }
            return;
        }
    }
    
    if (![self networkReachable]) {
        self.error = [NSError errorWithDomain:MMCNetworkErrorMessage code:MMCNetworkErrorCode userInfo:nil];
        if (failureHandler) {
            failureHandler(self.error);
        }
        return;
    }
    
    long long reqTime = [[NSDate date] timeIntervalSince1970]*1000;
    __block HttpClientComponent *component = self;
    sessionManager.requestSerializer.timeoutInterval = requsetTimeOutSeconds;
    NSLog(@"\nrequest url:%@ \nrequest:%@",url, [self jsonWithDict:bodyDictionary]);
    [sessionManager POST:url
              parameters:bodyDictionary
                progress:nil
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     component.responseDictionary = responseObject;
                     if(!responseObject){
                         !failureHandler?:failureHandler(nil);
                         return;
                     }
                     NSError *error;
                     component.responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
                     NSLog(@"responseData原始长度:%lu",(unsigned long)[component.responseData length]);
                     component.responseString =[[NSString alloc] initWithData:component.responseData encoding:NSUTF8StringEncoding];
                     
                     NSLog(@"\nresponse url:%@ \nresponse:%@",url, component.responseString);
                     //请求成功记录到缓存
                     long long respTime = [[NSDate date] timeIntervalSince1970]*1000;
                     [[NetworkCacheManager sharedManager] putCacheWithURL:url
                                                              requestBody:body
                                                              requestTime:reqTime
                                                                 response:component.responseString
                                                             responseTime:respTime];
                     
                     NSNumber *codeNum = component.responseDictionary[@"rcode"];

                     //SESSION失效的通知
                     if(RCODE_SESSION_INVALID == [codeNum integerValue]){
                         [Utils showToastWihtMessage:@"当前帐号已在其他手机登录"]; //当前帐号已在其他手机登录，如果非您本人登录，请注意帐号安全
                        // [[IMFLoginManager shareLoginManager] deletLoInUserModel];
                     }
                     
                     if (successHandler) {
                         successHandler(component.responseDictionary);
                     }

                     
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     NSLog(@"------请求失败-------%@",error);
                     component.error = error;
                     if (failureHandler) {
                         failureHandler(error);
                     }
                 }];
    
}

//下载文件，监听下载进度
- (void)downloadRequestWithUrl:(NSString *)url
                      progress:(progressBlock)progressHandler
             completionHandler:(responseBlock)completionHandler {
    if (![self networkReachable]) {
        if (progressHandler) {
            progressHandler(0, 0, 0);
        }
        if (completionHandler) {
            completionHandler(nil, nil);
        }
        return;
    }
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSProgress *kProgress = nil;

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * (NSURL *targetPath, NSURLResponse * response) {
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory :NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error){
        if (error) {
            NSLog(@"------下载失败-------%@",error);
        }
        if (completionHandler) {
            completionHandler(filePath, error);
        }
    }];
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask * downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        if (progressHandler) {
            progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }
    }];
    [downloadTask resume];
}

//上传文件，监听上传进度
- (void)uploadRequestWithUrl:(NSString *)url
                      params:(NSDictionary *)params
                  fileConfig:(HCFileConfig *)fileConfig
                    progress:(progressBlock)progressHandler
           completionHandler:(responseBlock)completionHandler {
    if (![self networkReachable]) {
        if (progressHandler) {
            progressHandler(0, 0, 0);
        }
        if (completionHandler) {
            completionHandler(nil, nil);
        }
        return;
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id  formData) {
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
    } error:nil];
    

    //获取上传进度
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                         @"text/json",
                                         @"text/javascript",
                                         @"text/html", nil];
    manager.responseSerializer = serializer;
    [manager setTaskDidSendBodyDataBlock:^(NSURLSession *session, NSURLSessionTask *task, int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        if (progressHandler) {
            progressHandler(bytesSent, totalBytesSent, totalBytesExpectedToSend);
        }
    }];
    
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"------上传失败-------%@",error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
        
        if (completionHandler) {
            completionHandler(responseObject, error);
        }
    }];
    
    [uploadTask resume];
    
}



#pragma mark -  some config & util


- (BOOL)networkReachable {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

- (NSString *)jsonWithDict:(NSDictionary *)dict{
    id data =[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

