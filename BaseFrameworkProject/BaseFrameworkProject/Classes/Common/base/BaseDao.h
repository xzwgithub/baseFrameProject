//
//  BaseDao.h
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "DBHelper.h"




@interface BaseDao : NSObject
{    
    FMDatabaseQueue *dbQueue;
#if __USEYTK__
    YTKKeyValueStore *store;
#endif
}



/**
 * 查询最新一条
 * @param 实体id
 * @return
 */
- (id)queryLast;


/**
 * 根据id查询
 * @param entityId
 * @return
 */
- (id)queryWithId:(id)entityId;

/**
 * 查询
 * @param entity
 * @return
 */
- (id)queryWithEntity:(Entity *)entity;

/**
 * 新增
 * @param entity
 * @return
 */
- (BOOL)insertWithEntity:(Entity *)entity;

/**
 * 修改
 * @param entity
 * @return
 */
- (BOOL)updateWithEntity:(Entity *)entity;

/**
 *
 * 删除
 * @param entity
 * @return
 */
- (BOOL)deleteWithEntity:(Entity *)entity;

/**
 * 根据rs获取实体对象
 *
 * @param rs
 * @return entity
 */
- (id)entityFromRS:(FMResultSet *)rs;

@end

@protocol StoreDao <NSObject>

@optional
/**
 * 表表名，使用YTKKeyValueStore时传入tableName非常方便
 * 需要继承的***Dao文件子实现
 */
- (NSString *)tableName;

@end
