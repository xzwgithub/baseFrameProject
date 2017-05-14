//
//  LoginManager.h
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "BaseManager.h"

@interface LoginManager : BaseManager

/**
 *  3.1.1 登录
 *
 *  @param parameter    参数
 *  @param succesBlock  成功回调
 *  @param failureBlock 失败回调
 */
+ (void)loginWithParameter:(NSDictionary *)parameter succes:(SuccesBlock)succesBlock failure:(FailureBlock)failureBlock;

/**
 *  3.1.1 注销
 *
 *  @param parameter    参数
 *  @param succesBlock  成功回调
 *  @param failureBlock 失败回调
 */
+ (void)logoutWithParameter:(NSDictionary *)parameter succes:(SuccesBlock)succesBlock failure:(FailureBlock)failureBlock;

@end
