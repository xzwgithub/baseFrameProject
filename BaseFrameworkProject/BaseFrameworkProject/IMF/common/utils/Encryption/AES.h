//
//  AES.h
//  UniversalArchitecture
//
//  Created by issuser on 13-1-8.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISSARC.h"


@class NSString;



@interface NSData (AES)



- (NSData *)AESEncryptWithKey:(NSString *)key;   //加密

- (NSData *)AESDecryptWithKey:(NSString *)key;   //解密

- (NSString *)newStringInBase64FromData;            //追加64编码

+ (NSString*)base64encode:(NSString*)str;           //同上64编码



@end