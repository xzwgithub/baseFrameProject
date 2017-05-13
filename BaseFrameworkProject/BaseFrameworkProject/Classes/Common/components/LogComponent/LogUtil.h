//
//  LogUtil.h
//
//  Created by issuser on 12-11-27.
//
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LogConfig.h"
#import "CrashLog.h"

/**
 日志组件，记录错误日志到文件
 
 依赖网络组件和 JSONKit
 
 */


@interface LogUtil : NSObject

/**
 记录日志记录到文件，日志文件位置为“可执行文件名(应用工程名).log”，在应用沙盒的Documents/log路经下
 可用宏定义判断是否需要在 debug 模式下也写入日志文件。
 如：
 
 @param nil
 @return nil
 */

+ (void)writeLogToFile;


//处理崩溃异常

+ (void)handleCrashException;

//是否保存的有崩溃报告

+ (BOOL)hasCrashReport;

//删除崩溃日志

- (void)deleteCrashReport;

/**
 崩溃日志内容
 @param fileName
 @return 内容字符串
 */


- (NSString *)getCrashContentByName:(NSString *)fileName;

/**
 给提示用户上传错误日志，用户点击确定后上传，如果点击取消将清除全部错误日志
 @param nil
 @return nil
 */

- (void)showTipBeforeUploadLog;

/**
 上传错误日志。此方法适用于无需弹框提醒用户的情况下上传错误日志
 @param nil
 @return nil
 */
- (void)uploadLog;

/**
 根据日志名获取日志发生时间
 @param 日志文件名
 @return nil
 */
- (long long)getLogOccurrenceTimeByLogName:(NSString *)fileName;

@end
