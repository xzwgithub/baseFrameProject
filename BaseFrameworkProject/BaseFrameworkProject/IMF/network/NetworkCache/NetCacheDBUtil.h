//
//  NetCacheDBUtil.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-18.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "ISSARC.h"

@interface NetCacheDBUtil : NSObject

+ (FMDatabase *)getDB;

@end
