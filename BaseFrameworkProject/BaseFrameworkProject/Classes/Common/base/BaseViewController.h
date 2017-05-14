//
//  BaseViewController.h
//  Sparrow
//
//  Created by issuser on 13-11-21.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISSMacros.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "UIImageView+WebCache.h"
#import "BaseBiz.h"
#import "ISSLog.h"
#import "XSLocalizedLanguage.h"
#import "XSLocalizedLanguageDef.h"
#import "NSString+MD5Addition.h"
#import "NSNumber+Formatter.h"//数字格式化
#import "StoryboardUtil.h"
#import "MJRefresh.h"
#import "RegularCheckUtil.h"
#import "AppConstants.h"
#import "UIView+Frame.h"
#import "LoginAccountManager.h"

#define kLoginDoneNotification          @"kLoginDoneNotification"


typedef void (^RetryBlock)();

typedef void(^FailedErrorBlock)(id);


//动画View
@interface LoadingView : UIView {
    BOOL isBlock;                                   //请求状态
}

@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end


@interface BaseViewController : UIViewController

@property (nonatomic, copy) FailedErrorBlock failedBlock;

@property (nonatomic, copy) RetryBlock retryBlock;
@property (nonatomic, strong) UIView *failedTipView;
@property (nonatomic, strong) UIView *noDataTipView;
@property (nonatomic, strong) UIView *noDataWithoutButtonView;
//登录
@property (nonatomic,strong) LoginAccountManager * loginAccountManager;


- (AppDelegate *)appDelegate;

//加载loading动画
- (void)showLoadingWith:(NSString *)text toView:(UIView *)view;

//移除loading动画
- (void)hideLoading;

//弹提示
-(void)showMBProgressHUD:(NSString *)message;

- (UIView *)noDataViewWithTitle:(NSString *)title;

- (UIView *)noDataViewNoButtonWithTitle:(NSString *)title;

/**
 *  隐藏键盘
 */
- (void)hindKeyBoard;

//MJ
/**
 *  下拉刷新
 */
@property (nonatomic, strong) MJRefreshGifHeader *header;

/**
 *  上拉加载更多
 */
@property (nonatomic, strong) MJRefreshBackNormalFooter *footer;
/**
 *  下拉刷新回调
 */
@property (nonatomic, copy) void (^refreshBlock)();
/**
 *  上拉加载回调
 */
@property (nonatomic, copy) void (^lodingBlock) ();

/**
 *  设置tableView 没有数据时候的View
 *
 * 
 */
- (void)setTableViewNodataImage:(BOOL)isNOdata withDataSorce:(NSArray *)dataSource atTableView:(UITableView *)tableView;



@end
