//
//  EncryptUtils.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/4.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import "EncryptUtils.h"
#import "GTMBase64.h"
#import "AESCrypt.h"
#import "DESCrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncryptUtils


+ (NSString *)AESEncrypt:(NSString *)tagetStr key:(NSString *)key{
    if (tagetStr == nil || [tagetStr length] == 0) {
        return nil;
    }
    if (key == nil || [key length] == 0) {
        return nil;
    }
    NSData *data = [tagetStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [AESCrypt AESEncrypt:data WithKey:key];
    
    return [GTMBase64 stringByEncodingData:resultData];
}

+ (NSString *)AESDecrypt:(NSString *)base64EncodedString key:(NSString *)key{
    if (base64EncodedString == nil || [base64EncodedString length] == 0) {
        return nil;
    }
    if (key == nil || [key length] == 0) {
        return nil;
    }
    
    NSData *data = [GTMBase64 decodeString:base64EncodedString];
    NSData *resultData = [AESCrypt AESDecrypt:data WithKey:key];
    
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}


+ (NSString *)DESEncrypt:(NSString *)tagetStr key:(NSString *)key{
    if (tagetStr == nil || [tagetStr length] == 0) {
        return nil;
    }
    if (key == nil || [key length] == 0) {
        return nil;
    }
    NSData *data = [tagetStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [DESCrypt DESEncrypt:data WithKey:key];
    
    return [GTMBase64 stringByEncodingData:resultData];
}

+ (NSString *)DESDecrypt:(NSString *)base64EncodedString key:(NSString *)key{
    if (base64EncodedString == nil || [base64EncodedString length] == 0) {
        return nil;
    }
    if (key == nil || [key length] == 0) {
        return nil;
    }
    
    NSData *data = [GTMBase64 decodeString:base64EncodedString];
    NSData *resultData = [DESCrypt DESDecrypt:data WithKey:key];
    
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}

+ (NSString *)MD5Encrypt:(NSString *)srcStr {
    
    const char *cStr = [srcStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [resultStr appendFormat:@"%02x", digest[i]];
    }
    return resultStr;
}

+ (NSString *)getMD5_16Bit_String:(NSString *)srcStr {
    
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self MD5Encrypt:srcStr];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}


+ (NSString *)MD5_FileEncrypt:(NSString *)path {
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle == nil ) return @"ERROR GETTING FILE MD5"; // file did not exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 100 ];
        CC_MD5_Update(&md5, [fileData bytes], (int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [resultStr appendFormat:@"%02x", digest[i]];
    }
    return resultStr;
}
@end
