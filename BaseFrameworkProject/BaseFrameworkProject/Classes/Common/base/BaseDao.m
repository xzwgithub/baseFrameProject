//
//  BaseDao.m
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import "BaseDao.h"
//#import "DBUtils.h"

@implementation BaseDao

- (id)init
{
    self = [super init];
    if (self) {
        //NSLog(@"super init BaseDao");
        
        //项目中只用到一个数据库，dao初始化的时候可以将db引用过来, 方便后续直接做增删改查
//        [self setCurrentDB:[DBUtils getDB]];
        dbQueue = [DBHelper sharedInstance].dbQueue;
#if __USEYTK__
        store = [DBHelper sharedInstance].store;
#endif
    }
    return self;
}
//- (void)setCurrentDB:(SQLiteDatabase *)currentDb {
//    db = currentDb;
//}


- (id)queryWithId:(id)entityId  { return nil; }
- (id)queryWithEntity:(Entity *)entity  { return nil; }
- (BOOL)insertWithEntity:(Entity *)entity {
#if __USEYTK__
    if (entity._id == nil) {
        NSLog(@"使用YTKKeyValueStore，实体id不能为空");
        return NO;
    }
    
    if ([((id<StoreDao>)self) respondsToSelector:@selector(tableName)]) {
        NSString *tableName = [((id<StoreDao>)self) tableName];
        [store putObject:[entity toDictionary] withId:entity._id intoTable:tableName];
        return YES;
    }
    else {
        NSLog(@"使用YTKKeyValueStore，需在***Dao.m实现返回表名的方法：- (NSString *)tableName;");
    }
    return NO;
#else 
    return nil;
#endif
}

- (BOOL)updateWithEntity:(Entity *)entity {
#if __USEYTK__
    return [self insertWithEntity:entity];
#else
    return nil;
#endif
}

- (BOOL)deleteWithEntity:(Entity *)entity {
#if __USEYTK__
    if (entity._id == nil) {
        NSLog(@"使用YTKKeyValueStore，实体id不能为空");
        return NO;
    }
    if ([((id<StoreDao>)self) respondsToSelector:@selector(tableName)]) {
        NSString *tableName = [((id<StoreDao>)self) tableName];
        [store deleteObjectById:entity._id fromTable:tableName];
        return YES;
    }
    else {
        NSLog(@"使用YTKKeyValueStore，需在***Dao.m实现返回表名的方法：- (NSString *)tableName;");
    }
    return NO;
#else
    return nil;
#endif
}
- (id)entityFromRS:(FMResultSet *)rs { return nil; }

@end
