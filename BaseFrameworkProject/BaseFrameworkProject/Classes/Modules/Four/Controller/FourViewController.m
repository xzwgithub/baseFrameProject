//
//  FourViewController.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "FourViewController.h"
#import "RootModel.h"
#import "UrlHeader.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Four";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"获取更新条数" style:UIBarButtonItemStylePlain target:self action:@selector(getUpdateCount)];
}

//模拟jsession失效
-(void)getUpdateCount
{
    HttpClientComponent *component = [[HttpClientComponent alloc] init];
    [component sendPOSTRequestWithUrl:DHOME_GET_STATISTIC_COUNT params:@{@"loginToken": [self.loginAccountManager getToken]}  success:^(NSDictionary *responseDictionary) {
        
        [Utils showToastWihtMessage:@"success"];
        
    } failure:^(NSError *error) {
        
         [Utils showToastWihtMessage:@"error"];
    }];

}


@end
