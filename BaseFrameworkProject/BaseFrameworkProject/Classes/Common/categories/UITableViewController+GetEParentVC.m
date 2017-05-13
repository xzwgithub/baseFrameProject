//
//  UITableViewController+GetEParentVC.m
//  LecShipper_iOS
//
//  Created by dyw on 16/12/1.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import "UITableViewController+GetEParentVC.h"

@implementation UITableViewController (GetEParentVC)

- (BaseViewController *)getBaseViewController{
    if(!self.navigationController || !self.navigationController.topViewController) return nil;
    BaseViewController *baseVC = (BaseViewController *)self.navigationController.topViewController;
    return baseVC;
}

@end
