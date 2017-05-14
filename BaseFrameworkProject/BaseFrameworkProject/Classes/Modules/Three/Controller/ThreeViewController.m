//
//  ThreeViewController.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "ThreeViewController.h"
#import "LoginManager.h"
#import "LoginViewController.h"
#import "ZWTabbarController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Three";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
}

-(void)logout
{
    [self showLoadingWith:@"正在注销..." toView:self.view];
    NSDictionary * dict = @{@"loginToken":[self.loginAccountManager getToken]};
    
    [LoginManager logoutWithParameter:dict succes:^(id model) {
        [self hideLoading];
        
        [self.loginAccountManager deleteUserLoginInfo];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NAME_BACKHOME object:nil];

        
    } failure:^(NSInteger errorCode, NSString *errorDirections) {
        [self hideLoading];
        [Utils showToastWihtMessage:errorDirections];
        
    }];
}



@end
