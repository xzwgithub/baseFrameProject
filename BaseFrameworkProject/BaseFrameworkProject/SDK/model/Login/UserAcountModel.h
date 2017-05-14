//
//  UserAcountModel.h
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "Entity.h"




@interface UserAcountModel : Entity

/**
 *  名字
 */
@property (nonatomic,copy) NSString * actualName;
/**
 *  车主id
 */
@property (nonatomic,copy) NSString * belong;

/**
 *  jsessionId
 */
@property (nonatomic,copy) NSString * jsessionId;

/**
 *  登录令牌
 */
@property (nonatomic,copy) NSString * loginToken;
/**
 *  手机
 */
@property (nonatomic,copy) NSString * mobilePhone;

/**
 *  密码
 */
@property (nonatomic,copy) NSString * password;
/**
 *  用户名
 */
@property (nonatomic,copy) NSString * userName;
/**
 *  用户类型
 */
@property (nonatomic,copy) NSString * userType;


@end
