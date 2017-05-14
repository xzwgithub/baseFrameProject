//
//  ZWNavController.m
//  XNWBDemo
//
//  Created by xzw on 16/10/31.
//  Copyright © 2016年 xzw. All rights reserved.
//

#import "ZWNavController.h"
#import "UIBarButtonItem+Extension.h"
#import "ViewParameterDefinition.h"


@interface ZWNavController ()

@end

@implementation ZWNavController


+(void)initialize
{
    UIBarButtonItem * item = [UIBarButtonItem appearanceWhenContainedIn:[self class], nil];
    
    //普通状态
    NSMutableDictionary * attribute = [NSMutableDictionary dictionary];
    attribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];

    //不可用状态
    NSMutableDictionary * disableAttribute = [NSMutableDictionary dictionary];
    disableAttribute[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disableAttribute forState:UIControlStateDisabled];
    
   //导航栏背景色
    [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setBarTintColor:ZDCL_NAV_BK];
   
    //设置title颜色和字体
    [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        //自动隐藏和显示tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置左边箭头按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"nav_back_arr" highImage:@"nav_back_arr"];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];

}

/**
 *  解决设置状态栏颜色无效
 */
- (UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}

@end
