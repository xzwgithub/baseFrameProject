//
//  AppDelegate.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/12.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "AppDelegate.h"
#import "GuidePageController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[GuidePageController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}




@end
