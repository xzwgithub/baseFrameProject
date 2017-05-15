//
//  ZWTabbarController.m
//  XNWBDemo
//
//  Created by xzw on 16/10/31.
//  Copyright © 2016年 xzw. All rights reserved.
//

#import "ZWTabbarController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "ZWNavController.h"
#import "ViewParameterDefinition.h"
#import "LoginViewController.h"
#import "LoginAccountManager.h"
#import "UserAcountModel.h"
#import "LoginManager.h"

@interface ZWTabbarController ()<UITabBarControllerDelegate>

@end

@implementation ZWTabbarController


+(void)initialize
{
    //普通状态
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [[UITabBarItem appearanceWhenContainedIn:[self class], nil] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //选中状态
    NSMutableDictionary * selectedAttributes = [NSMutableDictionary dictionary];
    selectedAttributes[NSForegroundColorAttributeName] = ZDCL_TABBAR_SELECT_TITLE;
    selectedAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [[UITabBarItem appearanceWhenContainedIn:[self class], nil] setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    //设置tabbar背景颜色
//    [[UITabBar appearanceWhenContainedIn:[self class], nil] setBarTintColor:[UIColor yellowColor]];
//    [UITabBar appearanceWhenContainedIn:[self class], nil].translucent = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    self.delegate = self;
    
    //添加子控制器
    [self setUpChildViewControllers];
    
    //注册通知
    [self addNotice];
    
    //自动登录请求
    [self autoLoginRequest];
}


//注册通知
-(void)addNotice
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backHomePage) name:NOTICE_NAME_BACKHOME object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsessionInvalide) name:NOTICE_JSESSIONID_INVALID object:nil];
}

//jsession失效
-(void)jsessionInvalide
{
    [Utils showToastWihtMessage:@"jsession失效"];
    
    //删除登录信息
    [[LoginAccountManager shareAccountManager] deleteUserLoginInfo];
    
    //跳转登录界
    if ([self isCurrentViewControllerVisible:[[LoginViewController alloc] init]]) return;
    [self backHomePage];
    
}

//判断UIViewController是否正在显示
-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController{
    return (viewController.isViewLoaded && viewController.view.window);
}


//回到登录界面
-(void)backHomePage
{
    [self setSelectedIndex:0];
    [[self.viewControllers firstObject]  pushViewController:[[LoginViewController alloc] init] animated:NO];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)autoLoginRequest
{
    if (![[LoginAccountManager shareAccountManager] isUserLogined]) return;
    UserAcountModel * userModel = [[LoginAccountManager shareAccountManager] getUserLoginInfo];
    NSString * userName = userModel.userName;
    NSString * password = userModel.password;
    
    NSDictionary * parames = @{@"userName":userName?:@"",@"password":password?:@"",@"userType":@"1"};
    NSLog(@"登录请求参数：%@",parames);
    [LoginManager loginWithParameter:parames succes:^(id model) {
        
        NSLog(@"自动登录成功...");
        UserAcountModel * userModel = model;
        //保存登录成功信息
        [[LoginAccountManager shareAccountManager]  saveLoginUserModel:userModel];
        
    } failure:^(NSInteger errorCode, NSString *errorDirections) {
        [Utils showToastWihtMessage:errorDirections];
        
    }];
}


#pragma mark -添加子控制器
-(void)setUpChildViewControllers
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"tabarItemTitle" ofType:@"plist"];
    NSArray * titles = [[NSArray alloc]initWithContentsOfFile:path];
    
    [self addChildViewController:[[OneViewController alloc]init] title:titles[0] imageName:@"main_tab_home" selectedImageName:@"main_tab_home_active"];
    
     [self addChildViewController:[[TwoViewController alloc]init] title:titles[1] imageName:@"main_tab_find" selectedImageName:@"main_tab_find_active"];
    
     [self addChildViewController:[[ThreeViewController alloc]init] title:titles[2] imageName:@"main_tab_order" selectedImageName:@"main_tab_order_active"];
    
     [self addChildViewController:[[FourViewController alloc]init] title:titles[3] imageName:@"main_tab_qu" selectedImageName:@"main_tab_qu_active"];

}

#pragma mark - 添加单个控制器
-(void)addChildViewController:(UIViewController*)viewController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName
{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ZWNavController* nav = [[ZWNavController alloc]initWithRootViewController:viewController];
    [self addChildViewController:nav];

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController 
{
    ZWNavController * nav = (ZWNavController*)viewController;
    BaseViewController * vc = nav.viewControllers.firstObject;
    if([vc isKindOfClass:[OneViewController class]] || [vc isKindOfClass:[TwoViewController class]])
    {
        return YES;
        
    }else
    {
      if([[LoginAccountManager shareAccountManager] isUserLogined])
      {
          return YES;
          
      }else
      {
          self.selectedIndex = 0;
          ZWNavController * firstNav =[self.viewControllers firstObject];
          [firstNav pushViewController:[[LoginViewController alloc] init] animated:NO];
          return NO;
      }
        
    }

}



@end
