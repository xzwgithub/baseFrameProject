//
//  NSDate+IMLDateAdd.h
//  ArchitectureTest
//
//  Created by 柯旗 on 15/12/16.
//  Copyright © 2015年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (IMLDateAdd)

#pragma mark - Date description（日期描述）
/**
 * 距离当前的时间间隔描述
 */
- (NSString *)timeIntervalDescription;
/*距离当前的时间间隔描述*/
- (NSString *)timeIntervalDescriptionSS;
/**
 精确到秒的日期描述
 */
- (NSString *)secondDescription;
/**
 * 精确到分钟的日期描述
 */
- (NSString *)minuteDescription;

/**
 * 标准时间日期描述
 */
- (NSString *)formattedTime;

/**
 * 格式化日期描述
 */
- (NSString *)formattedDateDescription;

/**
 * 日期转毫秒
 */
- (double)timeIntervalSince1970InMilliSecond;

/**
 * 毫秒转日期
 */
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**
 * 所传毫秒数转换为时间后的标准时间日期描述
 */
+ (NSString *)formattedTimeFromTimeInterval:(long long)time;

#pragma mark - Convert date into string or on the contrary （日期和日期字符串转换）

/**
 * 按默认格式把日期字符串转换成日期 （默认格式：yyyy-MM-dd HH:mm:ss）
 */
+ (NSDate *)dateFromString:(NSString *)string;

/**
 * 按自定义格式把日期字符串转换成日期
 */
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

/**
 * 按自定义格式把日期转换成日期字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;

/**
 * 按默认格式把日期转换成日期字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 * 按自己设定的时间样式把日期字符串转换成日期
 */
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

#pragma mark - Relative dates from the current date (获取当前日期前后n天、小时、分的日期)

/**
 * 获取明天的日期
 */
+ (NSDate *) dateTomorrow;

/**
 * 获取今天的日期
 */
+ (NSDate *) dateYesterday;

/**
 * 获取距离今天n天后的日期
 */
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;

/**
 * 获取距离今天n天前的日期
 */
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;

/**
 * 获取距离今天n小时后的日期
 */
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;

/**
 * 获取距离今天n小时前的日期
 */
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;

/**
 * 获取距离今天n分钟后的日期
 */
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;

/**
 * 获取距离今天n分钟前的日期
 */
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

#pragma mark - Comparing dates （比较日期）

/**
 * 比较年月日是否相等
 */
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

/**
 * 是否是今天
 */
- (BOOL) isToday;

/**
 * 是否是明天
 */
- (BOOL) isTomorrow;

/**
 * 是否是昨天
 */
- (BOOL) isYesterday;

/**
 * 是否是某年中的同一个星期
 */
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;

/**
 * 是否是这个星期
 */
- (BOOL) isThisWeek;

/**
 * 是否是下个星期
 */
- (BOOL) isNextWeek;

/**
 * 是否是上个星期
 */
- (BOOL) isLastWeek;

/**
 * 是否同年同月
 */
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;

/**
 * 是否与当前时间同月
 */
- (BOOL) isThisMonth;

/**
 * 是否同年
 */
- (BOOL) isSameYearAsDate: (NSDate *) aDate;

/**
 * 是否是今年
 */
- (BOOL) isThisYear;

/**
 * 是否是明年
 */
- (BOOL) isNextYear;

/**
 * 是否是去年
 */
- (BOOL) isLastYear;

/**
 * 是否早于另一个时间
 */
- (BOOL) isEarlierThanDate: (NSDate *) aDate;

/**
 * 是否晚于另一个时间
 */
- (BOOL) isLaterThanDate: (NSDate *) aDate;

/**
 * 是否晚于当前时间
 */
- (BOOL) isInFuture;

/**
 * 是否早于当前时间
 */
- (BOOL) isInPast;

/**
 * 是否是工作日
 */
- (BOOL) isTypicallyWorkday;

/**
 * 是否是休息日
 */
- (BOOL) isTypicallyWeekend;

#pragma mark - Adjusting dates （调整日期）

/**
 * n天后的日期
 */
- (NSDate *) dateByAddingDays: (NSInteger) dDays;

/**
 * n天前的日期
 */
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;

/**
 * n小时后的日期
 */
- (NSDate *) dateByAddingHours: (NSInteger) dHours;

/**
 * n小时前的日期
 */
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;

/**
 * n分钟后的日期
 */
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;

/**
 * n分钟前的日期
 */
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

/**
 * 零点日期
 */
- (NSDate *) dateAtStartOfDay;

#pragma mark - Retrieving intervals
/**
 * 比所传时间晚多少分钟
 */
- (NSInteger) minutesAfterDate: (NSDate *) aDate;

/**
 * 比所传时间早多少分钟
 */
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;

/**
 * 比所传时间晚多少小时
 */
- (NSInteger) hoursAfterDate: (NSDate *) aDate;

/**
 * 比所传时间早多少小时
 */
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;

/**
 * 比所传时间晚多少天
 */
- (NSInteger) daysAfterDate: (NSDate *) aDate;

/**
 * 比所传时间早多少天
 */
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

/**
 * 所传的时间与当前时间相差多少天
 */
- (NSInteger) distanceInDaysToDate:(NSDate *)anotherDate;


/**
 * 把时间转换成当地时间
 */
- (NSDate *)getDateOfLocalFormat;

/**
 * 计算某个月份有多少天
 */
+ (NSInteger)daysOfMonth:(NSString *)aDate;
- (NSInteger)daysOfMonth;

/**
 * 计算某年有多少个星期
 */
+ (NSInteger)weeksOfYear:(NSString *)aDate;
- (NSInteger)weeksOfYear;


#pragma mark - Decomposing dates (拆分日期)
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
