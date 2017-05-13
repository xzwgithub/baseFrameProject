//
//  DBConstants.h
//  UniversalArchitecture
//
//  Created by 张 黎 on 13-6-9.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *
 * 书库公共常量类 (需要写清楚注释，以"斜杠+两个星号"开头)
 * 数据库表名请修改数据库对应常量类中initialize方法中的static变量
 * 表的字段名请定义在.h本文件中，方便dao类使用
 * @author  zhangli
 * @version  [V1.0.1, 2013-12-13]
 */

@interface DBConstants : NSObject

+ (NSString *)dbName;


+ (NSString *)tableName;


+ (NSString *)getCreateSQL;


+ (NSString *)getInsertSQL;

+ (NSString *)getDeleteSQL;

+ (NSString *)getDeleteAllSQL;

+ (NSString *)getAlterSQL;

+ (NSString *)getQuerySQL;

/**
 *获取特殊条件的查询语句,  
 *@param nil
 *@return sql
 */

+ (NSString *)getQuerySQLV2;

+ (NSString *)getRowIdSQL;


@end

/*******************************TableNativeStorage****************************/

@interface TableNativeStorage : DBConstants

@end

/*******************************TableUser****************************/

@interface TableUser : DBConstants

@end

/*******************************TableProduct****************************/

@interface TableProduct : DBConstants

@end


/******************** 货物名称 ********************/

@interface TableGoodsName : DBConstants

@end


