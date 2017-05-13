//
//  LogConfig.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-10-14.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//日志文件前缀


#define CRASHLOG_FILE_PREFIX    @"ErrorReport"

#define URL_CRASHLOG_REPORT     @"http://10.8.64.44:9981/UEC/CrashLog/report"

/**************************错误日志提示语******************************/
#define kErr_Report_Title                       @"提示"
#define kErr_Report_Message                     @"有错误日志，是否上传？"
#define kErr_Report_Btn_Sure                    @"确定"
#define kErr_Report_Btn_Cancel                  @"取消"

@interface LogConfig : NSObject

/**
 错误日志文件名，为"ErrorReport-日期.txt"，如：ErrorReport_2005-08-22_23-59-59-122.txt (yyyy-MM-dd_HH-mm-ss-SSS)
 param  nil
 @return NSString * 文件名
 */

+ (NSString *)logFileName;


/**
 错误日志最大条数
 param nil
 @return long 条数
 */

+ (long)logFileMaxNum;


@end
