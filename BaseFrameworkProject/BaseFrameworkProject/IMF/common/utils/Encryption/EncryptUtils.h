//
//  EncryptUtils.h
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/4.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptUtils : NSObject

/**
 AES加密
 @param  tagetStr:需要加密的字符串
 key:用于加密的key
 @return 加密后的字符串
 */
+ (NSString *)AESEncrypt:(NSString *)tagetStr key:(NSString *)key;

/**
 AES解密
 @param  tagetStr:需要解密的字符串
 key:用于解密的key
 @return 解密后的字符串
 */
+ (NSString *)AESDecrypt:(NSString *)base64EncodedString key:(NSString *)key;

/**
 DES加密
 @param  tagetStr:需要加密的字符串
 key:用于加密的key
 @return 加密后的字符串
 */
+ (NSString *)DESEncrypt:(NSString *)tagetStr key:(NSString *)key;

/**
 DES解密
 @param  tagetStr:需要解密的字符串
 key:用于解密的key
 @return 解密后的字符串
 */
+ (NSString *)DESDecrypt:(NSString *)base64EncodedString key:(NSString *)key;


/**
 *  32位MD5加密方式
 *
 *  @param srcStr 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)MD5Encrypt:(NSString *)srcStr;

/**
 *  16位MD5加密方式
 *
 *  @param srcStr 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)getMD5_16Bit_String:(NSString *)srcStr;

/**
 *  文件MD5加密
 *
 *  @param path 需要加密的文件路径
 *
 *  @return 加密后的字符串
 */
+ (NSString *)MD5_FileEncrypt:(NSString *)path;
@end
