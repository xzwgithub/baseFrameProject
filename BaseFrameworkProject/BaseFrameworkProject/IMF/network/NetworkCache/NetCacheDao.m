//
//  NetCacheDao.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "NetCacheDao.h"
#import "NetCacheVO.h"

#define TABLE_NAME @"t_netCache"


@implementation NetCacheDao

- (id)init {
    if (self = [super init]) {
        // do something
        db = ISS_RETAIN([NetCacheDBUtil getDB]);
    }
    return self;
}

- (void)dealloc
{

    if (db==nil) {return;}
    else {[db close]; ISS_RELEASE(db); db =nil;}
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}



- (id)queryWithEntity:(NSObject *)entity {
    NetCacheVO *cacheVO = (NetCacheVO *)entity;
    NSMutableArray *returnArray = ISS_AUTORELEASE([[NSMutableArray alloc] init]);
    
    FMResultSet *rs = nil;
    if (cacheVO) {
        rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where url = ? and req = ?",TABLE_NAME], cacheVO.url, cacheVO.req];
    }
    else {
        rs = [db executeQuery:[NSString stringWithFormat:@"select * from %@ ORDER BY _id DESC",TABLE_NAME]];
    }
    
    while ([rs next]) {
        NetCacheVO *netCache = [[NetCacheVO alloc] init];
        netCache._id = [rs intForColumn:@"_id"];
        netCache.url = [rs stringForColumn:@"url"];
        netCache.req = [rs stringForColumn:@"password"];
        netCache.reqTime = [rs longLongIntForColumn:@"reqTime"];
        netCache.resp = [rs stringForColumn:@"resp"];
        netCache.respTime = [rs longLongIntForColumn:@"respTime"];
        
        [returnArray addObject:netCache];
        ISS_RELEASE(netCache);
    }
    [rs close];
    
    return returnArray;
}

- (BOOL)insertWithEntity:(NSObject *)entity {
    NetCacheVO *cacheVO = (NetCacheVO *)entity;
    
    BOOL success = YES;
    
    
    [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(url, req, reqTime, resp, respTime) VALUES (?,?,?,?,?)", TABLE_NAME], cacheVO.url, cacheVO.req, [NSNumber numberWithLongLong:cacheVO.reqTime], cacheVO.resp, [NSNumber numberWithLongLong:cacheVO.respTime]];
	if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
	}
    return success;
}
- (BOOL)updateWithEntity:(NSObject *)entity {
    NetCacheVO *cacheVO = (NetCacheVO *)entity;
    BOOL success = YES;
    
	[db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET url = ?, "
                       "req = ?, "
                       "reqTime = ?, "
                       "resp = ?, "
                       "respTime = ? "
                       "WHERE _id = ?", TABLE_NAME], cacheVO.url, cacheVO.req, [NSNumber numberWithLongLong:cacheVO.reqTime], cacheVO.resp, [NSNumber numberWithLongLong:cacheVO.respTime], [NSNumber numberWithInt:cacheVO._id]];
	if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
	}
	return success;
}

- (BOOL)deleteWithEntity:(NSObject *)entity {
    NetCacheVO *cacheVO = (NetCacheVO *)entity;
    
    BOOL success = YES;
    if (cacheVO) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE _id = ?",TABLE_NAME], [NSNumber numberWithInt:cacheVO._id]];
    }
    else {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",TABLE_NAME]];
    }
	if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
	}
	return success;
}


@end
