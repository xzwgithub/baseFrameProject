//
//  AppDelegate.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/12.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "AppDelegate.h"
#import "GuidePageController.h"
#import "ZWTabbarController.h"
#import "UUIDTools.h"
#import "LoginAccountManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = ![LoginAccountManager isFirstLogin]?self.tabbar: [[GuidePageController alloc] init];
    
    [self setHttpCommonParames];//设置网络请求公共参数
    
    
    return YES;
}


-(void)setHttpCommonParames
{
    NSString * deviceId = [UUIDTools getUUID];
    NSString * strMd5 = [NSString stringWithFormat:@"TT%@%@",@"APP_01",deviceId];
    NSString * secCode = [[strMd5 stringFromMD5]  uppercaseString];
    NSDictionary * parames = @{@"comParam":@{@"secCode":secCode,@"appType":@"APP_01",@"deviceId":deviceId}};
    NSLog(@"请求公共参数：%@",parames);
    [HttpClientComponent updateCommonParam:parames];
}

-(ZWTabbarController *)tabbar
{
    if (!_tabbar) {
        
        _tabbar = [[ZWTabbarController alloc] init];
    }
    return _tabbar;
}


@end
