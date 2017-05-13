//
//  DBHelper.m
//  SmartChargePal
//
//  Created by Wonder Chang on 15/9/6.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "DBHelper.h"

@interface DBHelper() {

}

@end
@implementation DBHelper

- (id)init
{
    self = [super init];
    if(self){
#if __USEYTK__
#else
        [self initDatabase];
#endif
    }
    return self;
}

+ (DBHelper *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (BOOL)initDatabase
{
    BOOL success;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *writableDBPath = [self dbPath];
    NSLog(@"database path:%@",writableDBPath);
    
    // 1、获取沙盒中数据库的路径  //解决FMDB error opening!: 14
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 2、判断 caches 文件夹是否存在.不存在则创建
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path isDirectory:NULL]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    
    success = [fm fileExistsAtPath:writableDBPath];
    //将初始数据库拷贝过去
    if (!success) {
        NSString *dbPath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[DBConstants dbName]];
        
        NSError *error;
        
        success = [fm copyItemAtPath:dbPath toPath:writableDBPath error:&error];
        
        if(!success)
        {
            NSLog(@"Failed to copy database...error handling here %@.", [error localizedDescription]);
        }
    }
    
    
    if(success){
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:writableDBPath];
        
        //建表可写在这里
        
        [_dbQueue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:[TableProduct getCreateSQL]];
        }];
        
    }
    
    return success;
}

- (void)inDatabase:(void(^)(FMDatabase *db))block
{
    [_dbQueue inDatabase:^(FMDatabase *db){
        block(db);
    }];
}

- (NSString *)dbPath {
    //与用户相关的数据库，需要这里修改。
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"] stringByAppendingPathComponent:[DBConstants dbName]];
}

+ (void)refreshDatabaseFile
{
    DBHelper *instance = [self sharedInstance];
    [instance doRefresh];
}

- (void)doRefresh
{
    NSString *dbFilePath = [self dbPath];
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
}

//数据库建表
- (void)createTables:(NSArray *)tables {
#if __USEYTK__
    for (NSString *tableName in tables) {
        [_store createTableWithName:tableName];
    }
#endif
}



#pragma mark - YTK reference methods

#if __USEYTK__
- (YTKKeyValueStore *)store {
    if (_store == nil) {
        _store = [[YTKKeyValueStore alloc] initDBWithName:[DBConstants dbName]];
        NSArray *tableNames = @[[TableNativeStorage tableName],
                                 [TableUser tableName],
                                [TableProduct tableName]];
        [self createTables:tableNames];
    }
    return _store;
}
#endif



@end
