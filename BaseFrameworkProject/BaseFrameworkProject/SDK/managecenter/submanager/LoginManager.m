//
//  LoginManager.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "LoginManager.h"
#import "UserAcountModel.h"

@implementation LoginManager

/**
 *  3.1.1 登录
 *
 *  @param parameter    参数
 *  @param succesBlock  成功回调
 *  @param failureBlock 失败回调
 */
+ (void)loginWithParameter:(NSDictionary *)parameter succes:(SuccesBlock)succesBlock failure:(FailureBlock)failureBlock{
    
#if IS_DEBUG //调试模式
    RootModel *rootModel = [RootModel yy_modelWithDictionary:[NSDictionary dictionaryWithNativeJsonFileName:@"login"]];
    
    if(rootModel && rootModel.rcode == 0){
        AccountObjModel*accountModel = [AccountObjModel yy_modelWithDictionary:rootModel.data];
        if(succesBlock){
            succesBlock(accountModel);
        }
    }else{
        if(failureBlock){
            failureBlock(rootModel.rcode, rootModel.resultMsg);
        }
    }
    
#else //正常模式
    
    HttpClientComponent *component = [[HttpClientComponent alloc] init];
    [component sendPOSTRequestWithUrl:DURL_LOGIN_LOGIN params:parameter success:^(NSDictionary *responseDictionary) {
        
        RootModel *rootModel = [RootModel yy_modelWithDictionary:responseDictionary];
        
        if(rootModel && rootModel.rcode == 0){
            
           UserAcountModel * accountObjModel = [UserAcountModel yy_modelWithDictionary:rootModel.data];
            
            if(succesBlock){
                succesBlock(accountObjModel);
            }
        }else{
            if(failureBlock){
                failureBlock(rootModel.rcode, rootModel.resultMsg);
            }
        }
        
    } failure:^(NSError *error) {
        if(failureBlock){
                       
            failureBlock(error.code, error.domain);
        }
    }];
#endif
}

/**
 *  3.1.1 注销
 *
 *  @param parameter    参数
 *  @param succesBlock  成功回调
 *  @param failureBlock 失败回调
 */
+ (void)logoutWithParameter:(NSDictionary *)parameter succes:(SuccesBlock)succesBlock failure:(FailureBlock)failureBlock{
    
#if IS_DEBUG //调试模式
    RootModel *rootModel = [RootModel yy_modelWithDictionary:[NSDictionary dictionaryWithNativeJsonFileName:@"regist"]];
    
    if(rootModel && rootModel.rcode == 0){
        if(succesBlock){
            succesBlock(rootModel);
        }
    }else{
        if(failureBlock){
            failureBlock(rootModel.rcode, rootModel.resultMsg);
        }
    }
#else //正常模式
    HttpClientComponent *component = [[HttpClientComponent alloc] init];
    [component sendPOSTRequestWithUrl:DURL_LOGIN_LOGOUT params:parameter success:^(NSDictionary *responseDictionary) {
        
        RootModel *rootModel = [RootModel yy_modelWithDictionary:responseDictionary];
        
        if(rootModel && rootModel.rcode == 0){
            if(succesBlock){
                succesBlock(rootModel);
            }
        }else{
            
            if(failureBlock){
                failureBlock(rootModel.rcode, rootModel.resultMsg);
            }
        }
        
    } failure:^(NSError *error) {
        if(failureBlock){
           failureBlock(error.code, error.domain);
        }
    }];
#endif
}



@end
