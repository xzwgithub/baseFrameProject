//
//  Netraffic.h
//  UniversalArchitecture
//
//  Created by DYL on 16/1/13.
//  Copyright © 2016年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface IMFMTraffic : NSObject
/**
 *  年
 */
@property (nonatomic, assign) NSInteger year;
/**
 *  月
 */
@property (nonatomic, assign) NSInteger month;

/**
 *  流量数
 */
@property (nonatomic, copy) NSString *traffic;

@end

@interface IMFNetraffic : NSObject {
    FMDatabase *db;
}

/**
 *  获取指定年月的流量
 *
 *  @param year  年 2016
 *  @param month 月 1
 *
 *  @return 流量大小 100KB
 */
- (NSString *)getLengthWith:(int)year month:(int)month;

/**
 *  获取 所有月份流量统计列表
 *
 *  @return IMFMTraffic 数组
 */
- (NSArray *)getMTrafficTable;

/**
 *  查询累计的所有流量大小
 *
 *  @return 累计的所有流量大小 100MB
 */
- (NSString *)getAllLength;

/**
 *  新增
 *
 *  @param date  时间 如果填nil 默认为当前时间
 *  @param lengthStr 长度字符串
 *
 *  @return 是否新增成功
 */
- (BOOL)insertWithTimeStr:(NSDate *)date length:(unsigned long)length;

/**
 *  字典转字节数量计算
 *
 *  @param dict 字典
 *
 *  @return 字典的子节数
 */
+(long long)returnDataLengthWithDictionary:(NSDictionary *)dict;

@end
