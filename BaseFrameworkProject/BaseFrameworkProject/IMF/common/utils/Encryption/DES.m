//
//  DES.m
//  UniversalArchitecture
//
//  Created by issuser on 13-1-8.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "DES.h"


@implementation DES


+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {
    
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
//        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
//        vplainText = (const void *)[data bytes];
    }
    
//    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
//    NSString *initVec = @"init Vec";
//    const void *vkey = (const void *) [key UTF8String];
//    const void *vinitVec = (const void *) [initVec UTF8String];
    
//    ccStatus = CCCrypt(encryptOrDecrypt,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding,
//                       vkey, //"123456789012345678901234", //key
//                       kCCKeySize3DES,
//                       vinitVec, //"init Vec", //iv,
//                       vplainText, //"Your Name", //plainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    free(bufferPtr);
    
    return result;
    
}

/*
 调用示例代码
 
 NSString* req = @"234234234234234中国";
 NSString* key = @"888fdafdakfjak;";
 
 NSString* ret1 = [NSString TripleDES:req encryptOrDecrypt:kCCEncrypt key:key];
 NSLog(@"3DES/Base64 Encode Result=%@", ret1);
 
 NSString* ret2 = [NSString TripleDES:ret1 encryptOrDecrypt:kCCDecrypt key:key];
 NSLog(@"3DES/Base64 Decode Result=%@", ret2);
 */


@end
