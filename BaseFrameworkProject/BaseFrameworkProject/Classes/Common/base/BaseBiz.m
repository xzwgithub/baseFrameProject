//
//  BaseBiz.m
//  UniversalArchitecture
//
//  Created by 张 黎 on 13-4-24.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "BaseBiz.h"
//#import "LoginViewController.h"

@implementation BaseBiz

+ (void)initialize {
    //只执行一次
    if ([@"BaseBiz" isEqualToString:NSStringFromClass([self class])]) {
        NSLog(@"设置网络请求组件相关配置");
        NSDictionary * cacheConfig = @{
                                       @"http://baidu.com/":@(15*60*1000)
                                       //                                       URL_REPORT_STATUS: @(15 * 60 * 1000),
                                       //                                       URL_COURSE_GETSCHEDULE : @(2 * 60 * 1000),
                                       //                                       URL_PUB_GETTEACHERCOURSES: @(2 * 60 * 1000)
                                       };
        [NetCacheConfig setCacheConfig:cacheConfig cacheMaxNumber:1000];
        
        NSArray *blackList = @[@"ip:port/login",
                               @"ip:port/getVerifyCode"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *loginToken = [defaults objectForKey:@"loginToken"];
        NSDictionary *dict = @{@"commonParam":@{@"os":@0,
                                                @"osVersion":[[UIDevice currentDevice] systemVersion],
                                                @"netType":[Utils netType],
                                                @"appVersion":[Utils appVersion],
                                                @"model":[[UIDevice currentDevice] model],
                                                @"screen":NSStringFromCGSize([[UIScreen mainScreen] currentMode].size),
                                                @"lan":[Utils getPreferredLanguage],
                                                @"pkg":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],
                                                @"loginToken":loginToken?loginToken:@""}};
        
        [HttpClientComponent setCommonParam:dict notUsedUrlBlackList:blackList];
        [HttpClientComponent setRequestTimeoutInterval:15];
    }

}

- (void)dealloc
{
    [self clearBlock];
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)clearBlock {
    if (completionBlock)
    {
        ISS_RELEASE(completionBlock);
        completionBlock = nil;
    }
    if (failedErrorBlock)
    {
        ISS_RELEASE(failedErrorBlock);
        failedErrorBlock = nil;
    }
}


- (void)requestFinished:(HttpClientComponent *)httpClientComponent {
    
    NSData *jsonData = [httpClientComponent responseData];
    NSError *error;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (responseDictionary) {
        int rcode = [[responseDictionary objectForKey:@"rcode"] intValue];
        if (rcode == 2) {
            //Session had invalidated.Session失效
            //弹出登录界面
            //[LoginViewController showLoginViewAnimated:NO];

        }
        else if (rcode == 3) {
            //请求的数据不存在
            completionBlock(nil);
            return;
        }
    }
    
    if (failedErrorBlock) {
        if (responseDictionary) {
            NSString *errMsg = [responseDictionary objectForKey:@"resultMsg"];
            if ([errMsg length]>0) {
                failedErrorBlock(errMsg);
            }
            else {
                failedErrorBlock(kGetDataError);
            }
        }
        else {
            failedErrorBlock(kGetDataError);
        }
    }
    
}

- (void)requestFailed:(HttpClientComponent *)httpClientComponent {
    //网络异常或超时（30秒） 提示：‘网络链接失败'。
    if (failedErrorBlock)
    {
        failedErrorBlock(kNetworkError);
    }
}

@end
