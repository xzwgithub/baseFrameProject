//
//  GuidePageController.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/12.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "GuidePageController.h"
#import "ZWTabbarController.h"
#import "LoginViewController.h"

@interface GuidePageController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation GuidePageController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickBtn:(id)sender {
    
    AppDelegate * delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = delegate.tabbar;
}

@end
