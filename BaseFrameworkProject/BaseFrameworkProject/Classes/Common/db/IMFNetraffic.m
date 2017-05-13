//
//  Netraffic.m
//  UniversalArchitecture
//
//  Created by DYL on 16/1/13.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import "IMFNetraffic.h"

static NSString *DATABASE_NAME = @"ua_cache.db"; //数据库名
static NSString *TABLE_NAME = @"netraffic_table"; //表名
static NSString *YEAR_STR = @"k_year";//年
static NSString *MONTH_STR = @"k_month";//月
static NSString *DAY_STR = @"k_day";//日
static NSString *TIME_STR = @"k_time";//时间
static NSString *LENGTH_STR = @"k_length";//长度

@implementation IMFMTraffic @end

@implementation IMFNetraffic

NSString *bytesToAvaiUnit(NSUInteger bytes);

- (id)init {
    if (self = [super init]) {
        // do something
        db = [IMFNetraffic getDB];
    }
    return self;
}

- (void)dealloc
{
    
    if (db==nil) {return;}
    else {[db close]; db =nil;}
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}


/**
 *  获取指定年月的流量
 *
 *  @param year  年
 *  @param month 月
 *
 *  @return 流量大小
 */
- (NSString *)getLengthWith:(int)year month:(int)month{
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT SUM(%@) FROM %@ where k_year = %d and k_month = %d", LENGTH_STR, TABLE_NAME, year, month]];
    
    if([rs next]){
        return bytesToAvaiUnit([rs.resultDictionary[@"SUM(k_length)"] integerValue]);
    }
    return nil;
}


/**
 *  获取 所有月份流量统计列表
 *
 *  @return IMFMTraffic 数组
 */
- (NSArray *)getMTrafficTable{
    
    FMResultSet *maxRs = [db executeQuery:[NSString stringWithFormat:@"SELECT MAX(%@) FROM %@", YEAR_STR, TABLE_NAME]];
    FMResultSet *minRs = [db executeQuery:[NSString stringWithFormat:@"SELECT MIN(%@) FROM %@", YEAR_STR, TABLE_NAME]];
    
    if(![maxRs next]||![minRs next]){
        return nil;
    }
    
    NSInteger maxYer = [maxRs.resultDictionary[@"MAX(k_year)"] integerValue];
    NSInteger minYer = [minRs.resultDictionary[@"MIN(k_year)"] integerValue];
    
    NSMutableArray *mTrafficArr = [NSMutableArray array];
    
    for (int i = (int)minYer; i <= maxYer; i++) {
        for (int j=1; j<=12; j++) {
            FMResultSet *mSumRs = [db executeQuery:[NSString stringWithFormat:@"SELECT SUM(%@) from %@ where k_year = %d and k_month = %d", LENGTH_STR, TABLE_NAME, i, j]];
            if([mSumRs next] && ![mSumRs.resultDictionary[@"SUM(k_length)"] isKindOfClass:[NSNull class]]){
                IMFMTraffic *mTraffic = [[IMFMTraffic alloc] init];
                mTraffic.year = i;
                mTraffic.month = j;
                mTraffic.traffic = bytesToAvaiUnit([mSumRs.resultDictionary[@"SUM(k_length)"] integerValue]);
                [mTrafficArr addObject:mTraffic];
            }
        }
    }
    
    return mTrafficArr;
}

/**
 *  查询累计的所有流量大小
 *
 *  @return 累计的所有流量大小
 */
- (NSString *)getAllLength{
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT SUM(%@) from %@", LENGTH_STR, TABLE_NAME]];
    
    if ([rs next]) {
        NSLog(@"==== %@", rs.resultDictionary);
        NSString * length = rs.resultDictionary[[NSString stringWithFormat:@"SUM(%@)", LENGTH_STR]];
        
        return bytesToAvaiUnit(length.integerValue);
    }
    
    return nil;
}

/**
 *  新增
 *
 *  @param date  时间 如果填nil 默认为当前时间
 *  @param lengthStr 长度字符串
 *
 *  @return 是否新增成功
 */
- (BOOL)insertWithTimeStr:(NSDate *)date length:(unsigned long)length{
    
    BOOL success = YES;
    
    NSDate *sevaDate = date?:[NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:sevaDate];
    
    int year = (int)[comps year];
    int month = (int)[comps month];
    int day = (int)[comps day];
    int hour = (int)[comps hour];
    int min = (int)[comps minute];
    int sec = (int)[comps second];
    
    NSString *hms_Str = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, sec];
    
    [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@('%@', '%@', '%@', '%@', '%@') VALUES (%d, %d, %d, '%@', %lu)", TABLE_NAME, YEAR_STR, MONTH_STR, DAY_STR, TIME_STR, LENGTH_STR, year, month, day, hms_Str, length]];
    
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        success = NO;
    }
//#warning test
//    NSArray *arr = [self getMTrafficTable];
//    NSString *str1 = [self getAllLength];
//    NSString *str2 = [self getLengthWith:2016 month:1];
    
    return success;
}

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
    if (![db tableExists:TABLE_NAME]) {
        NSLog(@"[NetCacheDBConstants getCreateSQL]:%@",[IMFNetraffic getCreateSQL]);
        [db executeUpdate:[IMFNetraffic getCreateSQL]] ? CFShow(@"create table succes") : CFShow(@"create table fail");
    }
    
    return db;
}

+ (NSString *)getCreateSQL{
    
    return [NSString stringWithFormat:
            @"CREATE TABLE IF NOT EXISTS "
            "%@"
            " (_id INTEGER PRIMARY KEY AUTOINCREMENT , "
            "%@"
            " INTEGER , "
            "%@"
            " INTEGER , "
            "%@"
            " INTEGER , "
            "%@"
            " TEXT , "
            "%@"
            " LONG )"
            , TABLE_NAME,
            YEAR_STR,
            MONTH_STR,
            DAY_STR,
            TIME_STR,
            LENGTH_STR
            ];
}

NSString *bytesToAvaiUnit(NSUInteger bytes){
    if(bytes < 1024){//B
        return [NSString stringWithFormat:@"%luB", bytes];
    }
    
    else if(bytes >= 1024 && bytes < 1024 * 1024){//KB
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
    }
    
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024){//MB
        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
    }
    
    else{//GB
        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

//字典转字节数量
+(long long)returnDataLengthWithDictionary:(NSDictionary *)dict{
    
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    
    return data.length;
}

@end
