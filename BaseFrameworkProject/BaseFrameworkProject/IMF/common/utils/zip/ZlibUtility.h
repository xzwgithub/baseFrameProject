//
//  ZlibUtility.h
//
//  Created by 张 黎 on 12-04-19.
//  Copyright (c) 2012年 张 黎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZlibUtility : NSObject


// 数据压缩

+ (NSData *)compressData:(NSData *)uncompressedData;

// 数据解压缩

+ (NSData *)decompressData:(NSData *)compressedData;


@end
