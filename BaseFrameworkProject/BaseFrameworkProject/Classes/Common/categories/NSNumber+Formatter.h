//
//  NSNumber+Formatter.h
//  HY_Logistics_iOS
//
//  Created by 君若见故 on 16/4/6.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  数字格式化
 */
@interface NSNumber (Formatter)

/**
 *  根据指定样式格式化数字
 *
 *  @param formatterStyle 格式化格式
 *  @param digit     小数部分位数
 */
- (NSString *)decimalNumberWithStyle:(NSNumberFormatterStyle)formatterStyle withFractionDigit:(NSInteger)digit;

/**
 *  重量保留四位小数
 */
- (NSString *)weightNumber;

/**
 *  体积保留两位小数
 */
- (NSString *)volumeNumber;

/**
 *  保留两位小数
 */
- (NSString *)twoSpotNumber;

@end
