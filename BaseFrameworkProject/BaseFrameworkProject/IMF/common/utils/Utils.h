//
//  Utils.h
//  UniversalArchitecture
//
//  Created by issuser on 13-1-11.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISSARC.h"
#import "UtilsHeaderFile.h"

@interface Utils : NSObject


/**
 *获取UUID
 */
+ (NSString *)uuid;

/**
 *获取时间戳
 */
+ (NSString *)timeStamp;

/**
 *返回从 UTC 1970 年 1 月 1 日午夜开始经过的毫秒数
 */
+ (long long)currentTimeMillis;

/**
 *Toast消息提示框
 */
+ (void)showToastWihtMessage:(NSString *)message;

/**
 *16进制颜色转换为UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 * 获取应用版本
 * param
 * @return NSString *
 */
+ (NSString *)appVersion;

/**
 * 获取应用包名
 * param
 * return NSString *
 */
+ (NSString *)bundleIdentifier;

/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)getPreferredLanguage;


//判断iPhone是否联网状态
+ (BOOL)isNetworkReachable;

//判断2G，3G，wifi网络类型
+ (NSString *)netType;


/**
 * 格式化日期为带星期的字符串 
 */

+ (NSString *)weekStringByFormatDateString:(NSString *)string;

+ (NSString *)stringByFormatDateString:(NSString *)string;

+ (UIView *)createTitleView:(NSString *)title leftName:(NSString *)left rightName:(NSString *)right target:(id)sel;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSString *)stringFromTimeMillis:(NSTimeInterval)time;

+ (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIButton *)navBackButtonItemWithTitle:(NSString *)title;

//文件大小格式化字符串
+ (NSString *)formattedFileSize:(unsigned long long)size;

+ (BOOL)isParentsVersion;
//截取字符串到规定的字符长度内
+ (NSString *)substringInMaxLength:(NSString *)text maxLength:(NSInteger)maxLength;
//检测字符串字符长度
+ (NSUInteger) unicodeLengthOfString: (NSString *) text;

//检测字符串是否为纯数字
+ (BOOL)isNumberText:(NSString *)string;
//检测邮箱格式是否正确
+ (BOOL)validateEmail:(NSString *)email;
//检测传值格式是否正确
+ (BOOL)validateFax:(NSString *)fax;
//检测除_与-之外的特殊字符是否存在
+ (BOOL)validateNoCharacterChar:(NSString *)string;
//检查是否是数字或者浮点数
+ (BOOL)validateNumberOrFloatText:(NSString *)string;

/**
 *  归档
 *
 *  @param obj  要归档的对象
 *  @param name 文件名
 */
+ (BOOL)archiveObject:(id)obj toName:(NSString *)name;

/**
 *  解归档
 *
 *  @param name 文件名
 */
+ (id)unArchiveFromName:(NSString *)name;


@end
