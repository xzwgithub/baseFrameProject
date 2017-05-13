//
//  NSNumber+Formatter.m
//  HY_Logistics_iOS
//
//  Created by 君若见故 on 16/4/6.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import "NSNumber+Formatter.h"

@implementation NSNumber (Formatter)

/**
 * NSNumberFormatterDecimalStyle //每三位数字，以逗号隔开
 */
- (NSString *)decimalNumberWithStyle:(NSNumberFormatterStyle)formatterStyle withFractionDigit:(NSInteger)digit {
    
    if (self==nil || self==NULL || [self isKindOfClass:[NSNull class]]) return @"0";

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = formatterStyle;
    formatter.minimumIntegerDigits = 1;
    formatter.maximumFractionDigits = digit;
    
    return [formatter stringFromNumber:self];
}

/**
 *  重量保留四位小数
 */
- (NSString *)weightNumber {

    return [self decimalNumberWithStyle:NSNumberFormatterNoStyle withFractionDigit:4];
}

/**
 *  体积保留两位小数
 */
- (NSString *)volumeNumber {
    return [self decimalNumberWithStyle:NSNumberFormatterNoStyle withFractionDigit:2];
}

/**
 *  保留两位小数
 */
- (NSString *)twoSpotNumber {
    
    if (self == nil) {
        return @"0";
    }
    NSString *str = [NSString stringWithFormat:@"%.2f",[self doubleValue]];
    NSNumber *num = @([str doubleValue]);
    return [num decimalNumberWithStyle:NSNumberFormatterDecimalStyle withFractionDigit:2];
}

@end
