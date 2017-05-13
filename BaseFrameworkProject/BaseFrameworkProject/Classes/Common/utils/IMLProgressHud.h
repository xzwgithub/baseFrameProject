//
//  IMLProgressHud.h
//  ArchitectureTest
//
//  Created by keqi on 16/8/3.
//  Copyright © 2016年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

/**
 *  注：不允许点击导航栏的返回键，View传nil即可
 */
@interface IMLProgressHud : NSObject

/**
 *  是否开启 单击隐藏提示框的手势
 */
@property (nonatomic) BOOL openHiddenGesture;

/**
 *  是否开启超时提醒(需要在提示信息之前设置)
 */
@property (nonatomic) BOOL openTimeOutPrompt;

/**
 *  提示框隐藏后的回调
 */
@property (nonatomic, copy) void (^hudWasHiddenBlock)();


+ (IMLProgressHud *)sharedInstance;

/**
 *  一直显示提示框，直到超时或者手动停止
 */
+ (void)showHudWithText:(NSString *)textString toView:(UIView *)view;

/**
 *  主动隐藏提示框
 */
+ (void)dismiss;

/**
 *自定义提示框显示时间
 *
 *  @param textString 提示信息
 *  @param duration   提示框显示的时长
 */
+ (void)showHudWithText:(NSString *)textString toView:(UIView *)view duration:(NSTimeInterval)duration;

/**
 *  提示框默认展示1秒后自动隐藏
 */
+ (void)showAutomicHiddenHudText:(NSString *)textString toView:(UIView *)view;

/**
 *  展示自定义的视图
 */
+ (void)showHudWithCustomView:(UIView *)customView toView:(UIView *)view;
@end
