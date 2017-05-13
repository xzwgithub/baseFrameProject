//
//  NetCacheDBConstants.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "NetCacheDBConstants.h"

@implementation NetCacheDBConstants

static NSString *TABLE_NAME = @"t_netCache";

static NSString *COLUMN_URL = @"url";
static NSString *COLUMN_REQ = @"req";
static NSString *COLUMN_REQTIME = @"reqTime";
static NSString *COLUMN_RESP = @"resp";
static NSString *COLUMN_RESPTIME = @"respTime";


+ (NSString *)tableName {
    return TABLE_NAME;
}

+ (NSString *)getAlterSQLOfV2 { return nil; }

+ (NSString *)getAlterSQLOfV3 { return nil; }

+ (NSString *)getCreateSQL {
    return [NSString stringWithFormat:
            @"CREATE TABLE IF NOT EXISTS "
            "%@"
            " (_id INTEGER PRIMARY KEY AUTOINCREMENT , "
            "%@"
            " TEXT , "
            "%@"
            " TEXT , "
            "%@"
            " INTEGER , "
            "%@"
            " TEXT , "
            "%@"
            " INTEGER )"
            , TABLE_NAME,
            COLUMN_URL,
            COLUMN_REQ,
            COLUMN_REQTIME,
            COLUMN_RESP,
            COLUMN_RESPTIME];
}

@end
