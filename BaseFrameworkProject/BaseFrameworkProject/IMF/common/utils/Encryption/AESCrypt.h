//
//  AESCrypt.h
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/4.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESCrypt : NSObject 

/**
 AES加密
 @param  data 加密的数据
 @param  key 用于加密的key
 @return 加密后的数据
 */
+ (NSData *)AESEncrypt:(NSData *)data WithKey:(NSString *)key;

/**
 AES解密
 @param  data 解密的数据
 @param  key 用于解密的key
 @return 解密后的数据
 */
+ (NSData *)AESDecrypt:(NSData *)data WithKey:(NSString *)key;


@end
