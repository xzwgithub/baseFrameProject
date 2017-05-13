//
//  NetCacheDao.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetCacheDBUtil.h"

@interface NetCacheDao : NSObject {
    FMDatabase *db;
}

/**
 * 查询
 * @param entity
 * @return
 */
- (id)queryWithEntity:(NSObject *)entity;

/**
 * 新增
 * @param entity
 * @return
 */
- (BOOL)insertWithEntity:(NSObject *)entity;

/**
 * 修改
 * @param entity
 * @return
 */
- (BOOL)updateWithEntity:(NSObject *)entity;

/**
 *
 * 删除
 * @param entity
 * @return
 */
- (BOOL)deleteWithEntity:(NSObject *)entity;



@end
