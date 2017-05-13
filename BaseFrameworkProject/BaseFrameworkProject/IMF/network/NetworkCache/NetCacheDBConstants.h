//
//  NetCacheDBConstants.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetCacheDBConstants :  NSObject

+ (NSString *)tableName;


+ (NSString *)getCreateSQL;


+ (NSString *)getAlterSQLOfV2;


+ (NSString *)getAlterSQLOfV3;

@end
