//
//  LoginAccountManager.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "LoginAccountManager.h"
#import <YTKKeyValueStore.h>

#define USER_LOGIN_DBNAME @"user_login_dbName.db"//数据库名
#define USER_LOGIN_TBNAME @"user_login_tbName"//表名
#define USER_LOGIN_USERINFO @"user_login_userInfo"//用户信息
#define APP_VERSION_KEY @"versionKey"

@interface LoginAccountManager ()
@property (nonatomic,strong) YTKKeyValueStore * dbStore;
@end


@implementation LoginAccountManager
static LoginAccountManager * instance = nil;

-(YTKKeyValueStore *)dbStore
{
    if (!_dbStore) {
        
        _dbStore = [[YTKKeyValueStore alloc] initDBWithName:USER_LOGIN_DBNAME];
        [_dbStore createTableWithName:USER_LOGIN_TBNAME];
    }
    
    return _dbStore;
}

+(instancetype)shareAccountManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[LoginAccountManager alloc] init];
        
    });
    return instance;
}

+(BOOL)isFirstLogin
{
    NSDictionary * infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString * defaultVersion = [[NSUserDefaults standardUserDefaults] objectForKey:APP_VERSION_KEY];
    if ([currentVersion isEqualToString:defaultVersion]) {
        
        return NO;//不是该版本第一个登录
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:APP_VERSION_KEY];
        return YES;
    }
}

-(BOOL)isUserLogined
{
    return [self.dbStore getObjectById:USER_LOGIN_USERINFO fromTable:USER_LOGIN_TBNAME]?YES:NO;
}

-(void)saveLoginUserModel:(UserAcountModel *)userModel
{
    NSDictionary * dict = [userModel toDictionary];
    [self.dbStore putObject:dict withId:USER_LOGIN_USERINFO intoTable:USER_LOGIN_TBNAME];
}

-(UserAcountModel *)getUserLoginInfo
{
    NSDictionary * dict = [self.dbStore getObjectById:USER_LOGIN_USERINFO fromTable:USER_LOGIN_TBNAME];
    UserAcountModel * userModel = [UserAcountModel yy_modelWithDictionary:dict];
    return userModel;
}

-(NSString *)getToken
{
    UserAcountModel * userModel = [self getUserLoginInfo];
    return userModel.loginToken?:@"";
}

-(void)deleteUserLoginInfo
{
    [self.dbStore deleteObjectById:USER_LOGIN_USERINFO fromTable:USER_LOGIN_TBNAME];
}

@end
