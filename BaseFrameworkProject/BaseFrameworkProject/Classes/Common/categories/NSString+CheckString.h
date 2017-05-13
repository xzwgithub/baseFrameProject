//
//  NSString+CheckString.h
//  ZZGXProject
//
//  Created by keqi on 15/3/31.
//  Copyright (c) 2015年 keqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckString)

//校验字符串是否为空
+ (BOOL)isBlankString:(NSString *)str;

- (BOOL)isBlankStr;

//字符串转Number
- (NSNumber *)toNumber;

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

@end
