//
//  NSDateFormatter+DateFormatterAdd.m
//  ArchitectureTest
//
//  Created by 柯旗 on 15/12/16.
//  Copyright © 2015年 iSoftStone. All rights reserved.
//

#import "NSDateFormatter+DateFormatterAdd.h"

@implementation NSDateFormatter (DateFormatterAdd)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
