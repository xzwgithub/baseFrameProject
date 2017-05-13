//
//  NetCacheDBUtil.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-18.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "NetCacheDBUtil.h"
#import "NetCacheDBConstants.h"

static NSString *DATABASE_NAME = @"net_cahce.db";

@implementation NetCacheDBUtil

+ (FMDatabase *)getDB {
    
	NSString *dbPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"] stringByAppendingPathComponent:DATABASE_NAME];
    
    FMDatabase *db = nil;
    db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        [db setShouldCacheStatements:YES];
        NSLog(@"Open success %@ !", DATABASE_NAME);
    }else {
        NSLog(@"Failed to open %@ !", DATABASE_NAME);
    }
        
    //如果需要建表    
    if (![db tableExists:[NetCacheDBConstants tableName]]) {
        NSLog(@"[NetCacheDBConstants getCreateSQL]:%@",[NetCacheDBConstants getCreateSQL]);
        [db executeUpdate:[NetCacheDBConstants getCreateSQL]] ? CFShow(@"create table succes") : CFShow(@"create table fail");
    }

    return db;
}



@end
