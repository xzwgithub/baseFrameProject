//
//  LoginViewController.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "LoginViewController.h"
#import "AppConstants.h"
#import "ZWCustomTextField.h"
#import "LoginManager.h"
#import "UserAcountModel.h"
#import "ZWTabbarController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet ZWCustomTextField *userNameTF;
@property (weak, nonatomic) IBOutlet ZWCustomTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.scrollViewHeightConstraint.constant = SCREEN_HEIGHT + 20;
    
}
- (IBAction)longin:(id)sender {
    
    [self loginRequestWithUsername:self.userNameTF.text password:self.passwordTF.text];
    
}

-(void)loginRequestWithUsername:(NSString*)userName password:(NSString*)password{
    
    [self showLoadingWith:@"登录中..." toView:self.view];
    NSDictionary * parames = @{@"userName":userName,@"password":[password stringFromMD5],@"userType":@"1"};
    NSLog(@"登录请求参数：%@",parames);
    [LoginManager loginWithParameter:parames succes:^(id model) {
        
        [self hideLoading];
        
        UserAcountModel * userModel = model;
        //保存登录成功信息
        [self.loginAccountManager saveLoginUserModel:userModel];
        
        //保存登录账号历史纪录
        [self.loginAccountManager saveHistoryUserModels:userModel];
        
        //跳转tabbar控制器
        [self.navigationController popViewControllerAnimated:YES];
        

    } failure:^(NSInteger errorCode, NSString *errorDirections) {
        [self hideLoading];
        [Utils showToastWihtMessage:errorDirections];
        
    }];
    
}

-(void)dealloc
{
    NSLog(@"LoginViewController----dealloc");
}


@end
