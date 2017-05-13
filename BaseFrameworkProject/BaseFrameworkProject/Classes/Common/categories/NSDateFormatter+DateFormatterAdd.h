//
//  NSDateFormatter+DateFormatterAdd.h
//  ArchitectureTest
//
//  Created by 柯旗 on 15/12/16.
//  Copyright © 2015年 iSoftStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (DateFormatterAdd)

+ (id)dateFormatter;

+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

/*
该格式可以指定以下内容:

G: 公元时代，例如AD公元

yy: 年的后2位

yyyy: 完整年

MM: 月，显示为1-12

MMM: 月，显示为英文月份简写,如 Jan

MMMM: 月，显示为英文月份全称，如 Janualy

dd: 日，2位数表示，如02

d: 日，1-2位显示，如 2

EEE: 简写星期几，如Sun

EEEE: 全写星期几，如Sunday

aa: 上下午，AM/PM

H: 时，24小时制，0-23

h：时，12小时制，0-11

m: 分，1-2位

mm: 分，2位

s: 秒，1-2位

ss: 秒，2位

S: 毫秒
 */
@end
