//
//  CrashLog.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-10-14.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashLog : NSObject

/**
 when                   Long	日志发生时间
 content                String	日志信息，具体内容
 type                   Integer	日志类型 0: 一般日志 1: 错误日志
 */
@property (nonatomic, assign) long long when;

@property (nonatomic, retain) NSString *content;

@property (nonatomic, assign) NSInteger type;

/**
 对象转字典，用于后续方便转 json
 param  nil
 @return json字符串
 */
- (NSDictionary *)toDictionary;

/**
 对象转json
 param  nil
 @return json字符串
 */

- (NSString *)toJsonStr;


@end
