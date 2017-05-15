//
//  LoginAccountManager.h
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAcountModel.h"

@interface LoginAccountManager : NSObject

+(instancetype)shareAccountManager;

+(BOOL)isFirstLogin;

-(BOOL)isUserLogined;

//保存用户登录信息
-(void)saveLoginUserModel:(UserAcountModel*)userModel;

//保存用户历史登录信息
-(void)saveHistoryUserModels:(UserAcountModel*)userModel;

//获取用户登录信息
-(UserAcountModel*)getUserLoginInfo;

//获取登录token
-(NSString*)getToken;

//获取历史登录账号信息
-(NSMutableArray*)getAllHistoryLoginAccountInfo;

//删除当前用户登录信息
-(void)deleteUserLoginInfo;

@end
