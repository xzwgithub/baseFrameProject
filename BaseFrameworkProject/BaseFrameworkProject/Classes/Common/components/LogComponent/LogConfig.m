//
//  LogConfig.m
//  MISUniversalECommerce
//
//  Created by issuser on 13-10-14.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import "LogConfig.h"

@implementation LogConfig


/**
 * 允许的崩溃日志的最大数
 */
static int CRASH_LOG_MAX_NUM = 5;

/**
 错误日志文件名，为"ErrorReport-日期.txt"，如：ErrorReport_2005-08-22_23-59-59-122.txt (yyyy-MM-dd_HH-mm-ss-SSS)
 @param  nil
 @return NSString * 文件名
 */

+ (NSString *)logFileName {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss-SSS"];
    return [NSString stringWithFormat:@"%@_%@.txt", CRASHLOG_FILE_PREFIX,[dateFormatter stringFromDate:[NSDate date]]];
}


/**
 错误日志最大条数
 @param nil
 @return long 条数
 */

+ (long)logFileMaxNum {
    return CRASH_LOG_MAX_NUM;
}

@end
