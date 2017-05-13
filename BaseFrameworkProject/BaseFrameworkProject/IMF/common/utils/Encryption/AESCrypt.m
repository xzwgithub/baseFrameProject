//
//  AESCrypt.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/4.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import "AESCrypt.h"
#import "NSData+CommonCrypto.h"
#import "GTMBase64.h"

@implementation AESCrypt



+ (NSData *)AESEncrypt:(NSData *)data WithKey:(NSString *)key {
  NSData *encryptedData = [data AES256EncryptedDataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    
  return encryptedData;
}



+ (NSData *)AESDecrypt:(NSData *)data WithKey:(NSString *)key{
  NSData *decryptedData = [data decryptedAES256DataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    
  return decryptedData;
}

@end
