//
//  DBConstants.m
//  UniversalArchitecture
//
//  Created by 张 黎 on 13-6-9.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "DBConstants.h"

static NSString *DATABASE_NAME = @"ua_cache.db";

static NSString *COLUMN_ID = @"id";

@implementation DBConstants

+ (NSString *)dbName { return DATABASE_NAME; }


+ (NSString *)tableName { return nil; }


+ (NSString *)getCreateSQL { return nil; }


+ (NSString *)getInsertSQL { return nil; }

+ (NSString *)getDeleteSQL { return nil; }

+ (NSString *)getDeleteAllSQL { return nil; }

+ (NSString *)getAlterSQL { return nil; }

+ (NSString *)getQuerySQL { return nil; }

+ (NSString *)getQuerySQLV2 { return nil; }

+ (NSString *)getRowIdSQL { return nil; }

@end

@implementation TableNativeStorage

static NSString *COLUMN_JS_NAME    = @"name";
static NSString *COLUMN_JS_VALUE   = @"value";

static NSString *NATIVE_STORAGE_TABLE_NAME = @"t_nativestorage";

+ (NSString *)tableName {
    
    return NATIVE_STORAGE_TABLE_NAME;

}


+ (NSString *)getCreateSQL {
    return [NSString stringWithFormat:
            @"CREATE TABLE IF NOT EXISTS "
            "%@"
            " (_id INTEGER PRIMARY KEY AUTOINCREMENT , "
            "%@"
            " TEXT , "
            "%@"
            " TEXT )"
            , NATIVE_STORAGE_TABLE_NAME, COLUMN_JS_NAME, COLUMN_JS_VALUE];
}

+ (NSString *)getQuerySQL {
    return [NSString stringWithFormat:
            @"select * from %@ order by _id desc",
            NATIVE_STORAGE_TABLE_NAME];
}


+ (NSString *)getQuerySQLV2 {
    return [NSString stringWithFormat:
            @"select * from %@ where "
            "%@ = ?",
            NATIVE_STORAGE_TABLE_NAME,
            COLUMN_ID];
}

+ (NSString *)getInsertSQL {
    return [NSString stringWithFormat:
            @"INSERT INTO %@(%@, %@) "
            "VALUES (?,?)",
            NATIVE_STORAGE_TABLE_NAME,
            COLUMN_JS_NAME, COLUMN_JS_VALUE];
}

+ (NSString *)getAlterSQL {
    return [NSString stringWithFormat:
            @"UPDATE %@ SET value = ? WHERE %@ = ?",
            NATIVE_STORAGE_TABLE_NAME,
            COLUMN_JS_NAME];
}


+ (NSString *)getDeleteAllSQL {
    return [NSString stringWithFormat:@"DELETE FROM %@ ",NATIVE_STORAGE_TABLE_NAME];
}

+ (NSString *)getDeleteSQL {
    return [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",NATIVE_STORAGE_TABLE_NAME, COLUMN_JS_NAME];
}


@end

@implementation TableUser

static NSString *const COLUMN_UNAME   = @"name";
static NSString *const COLUMN_PHONE   = @"phone";
static NSString *const COLUMN_INTR    = @"introduction";


static NSString *const USER_TABLE_NAME = @"t_user";

+ (NSString *)tableName {
    return USER_TABLE_NAME;
}

+ (NSString *)getCreateSQL {
    return [NSString stringWithFormat:
            @"CREATE TABLE IF NOT EXISTS %@("
            "_id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "%@ TEXT, "
            "%@ TEXT, "
            "%@ TEXT)",
            USER_TABLE_NAME, COLUMN_UNAME, COLUMN_PHONE, COLUMN_INTR];
}

+ (NSString *)getInsertSQL {
    return [NSString stringWithFormat:
            @"INSERT INTO %@(%@, %@, %@, %@) "
            "VALUES (?,?,?,?)",
            USER_TABLE_NAME,
            COLUMN_ID, COLUMN_UNAME, COLUMN_PHONE, COLUMN_INTR];
}

+ (NSString *)getAlterSQL {
//    return [NSString stringWithFormat:
//            @"UPDATE %@ SET "
//            "%@ = ?, %@ = ?, %@ = ?"
//            "WHERE %@ = ?",
//            USER_TABLE_NAME,
//            COLUMN_UNAME, COLUMN_PHONE, COLUMN_INTR,
//            COLUMN_ID];
    
    return [NSString stringWithFormat:
            @"REPLACE INTO %@(%@, %@, %@, %@) "
            "VALUES (?,?,?,?)",
            USER_TABLE_NAME,
            COLUMN_ID, COLUMN_UNAME, COLUMN_PHONE, COLUMN_INTR];
}

+ (NSString *)getDeleteSQL {
    return [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",
            USER_TABLE_NAME, COLUMN_ID];
}

+ (NSString *)getDeleteAllSQL {
    return [NSString stringWithFormat:@"DELETE FROM %@",USER_TABLE_NAME];
}

+ (NSString *)getQuerySQL {
    return [NSString stringWithFormat:
            @"select * from %@ "
            "order by rowid DESC limit 0,1",
            USER_TABLE_NAME];
}

+ (NSString *)getQuerySQLV2 {
    return [NSString stringWithFormat:
            @"select * from %@ "
            "where %@ = ?",
            USER_TABLE_NAME, COLUMN_ID];
}

+ (NSString *)getRowIdSQL {
    return [NSString stringWithFormat:
            @"select rowid from %@ where "
            "%@ = ?",
            USER_TABLE_NAME,
            COLUMN_ID];
}




@end


@implementation TableProduct

static NSString *const COLUMN_NAME   = @"name";
static NSString *const COLUMN_PRICE   = @"price";
static NSString *const COLUMN_INTRO    = @"intro";


static NSString *const USER_TABLE_PRODUCT = @"t_product";

+ (NSString *)tableName {
    return USER_TABLE_PRODUCT;
}

+ (NSString *)getCreateSQL {
    return [NSString stringWithFormat:
            @"CREATE TABLE IF NOT EXISTS %@("
            "%@ TEXT PRIMARY KEY, "
            "%@ TEXT, "
            "%@ TEXT, "
            "%@ TEXT)",
            USER_TABLE_PRODUCT, COLUMN_ID, COLUMN_NAME, COLUMN_PRICE, COLUMN_INTRO];
}

+ (NSString *)getInsertSQL {
    return [NSString stringWithFormat:
            @"INSERT INTO %@(%@, %@, %@, %@) "
            "VALUES (?,?,?,?)",
            USER_TABLE_PRODUCT, COLUMN_ID, COLUMN_NAME, COLUMN_PRICE, COLUMN_INTRO];
}

+ (NSString *)getAlterSQL {
    //    return [NSString stringWithFormat:
    //            @"UPDATE %@ SET "
    //            "%@ = ?, %@ = ?, %@ = ?"
    //            "WHERE %@ = ?",
    //            USER_TABLE_NAME,
    //            COLUMN_UNAME, COLUMN_PHONE, COLUMN_INTR,
    //            COLUMN_ID];
    
    return [NSString stringWithFormat:
            @"REPLACE INTO %@(%@, %@, %@, %@) "
            "VALUES (?,?,?,?)",
            USER_TABLE_PRODUCT,
            COLUMN_ID, COLUMN_NAME, COLUMN_PRICE, COLUMN_INTRO];
}

+ (NSString *)getDeleteSQL {
    return [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",
            USER_TABLE_PRODUCT, COLUMN_ID];
}

+ (NSString *)getDeleteAllSQL {
    return [NSString stringWithFormat:@"DELETE FROM %@",USER_TABLE_NAME];
}

+ (NSString *)getQuerySQL {
    return [NSString stringWithFormat:
            @"select * from %@ "
            "order by rowid DESC limit 0,1",
            USER_TABLE_PRODUCT];
}

+ (NSString *)getQuerySQLV2 {
    return [NSString stringWithFormat:
            @"select * from %@ "
            "where %@ = ?",
            USER_TABLE_PRODUCT, COLUMN_ID];
}

+ (NSString *)getRowIdSQL {
    return [NSString stringWithFormat:
            @"select rowid from %@ where "
            "%@ = ?",
            USER_TABLE_PRODUCT,
            COLUMN_ID];
}

@end



#pragma mark /******************** 货物名称 ********************/

@implementation TableGoodsName

static NSString *TABLE_GOODSNAME = @"GoodsName";

NSString *const nameId = @"nameId";
NSString *const name = @"name";
NSString *const businessModelClassify = @"businessModelClassify";
NSString *const baseClassify = @"baseClassify";


+ (NSString *)tableName { return TABLE_GOODSNAME; }

+ (NSString *)getQuerySQL {
    return [NSString stringWithFormat:
            @"select * from %@",
            TABLE_GOODSNAME];
}

+ (NSString *)getQuerySQLV2 {
    return [NSString stringWithFormat:
            @"select * from %@ where "
            "%@ = ?",
            TABLE_GOODSNAME,
            nameId];
}

+ (NSString *)getInsertSQL {
    return [NSString stringWithFormat:
            @"INSERT INTO %@(%@, %@, %@, %@) "
            "VALUES (?,?,?,?)",
            TABLE_GOODSNAME,
            nameId, name, businessModelClassify, baseClassify];
}

+ (NSString *)getAlterSQL {
    return [NSString stringWithFormat:
            @"UPDATE %@ SET "
            "%@ = ?, %@ = ?, %@ = ?"
            "WHERE %@ = ?",
            TABLE_GOODSNAME,
            name, businessModelClassify, baseClassify, nameId];
}

+ (NSString *)getDeleteSQL {
    return [NSString stringWithFormat:
            @"DELETE FROM %@ "
            "WHERE %@ = ?",
            TABLE_GOODSNAME, nameId];
}

+ (NSString *)getDeleteAllSQL {
    return [NSString stringWithFormat:
            @"DELETE FROM %@",
            TABLE_GOODSNAME];
}

@end
