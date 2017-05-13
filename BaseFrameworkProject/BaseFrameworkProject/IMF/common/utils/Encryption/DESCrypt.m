//
//  DESCrypt.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/4.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import "DESCrypt.h"
#import "NSData+CommonCrypto.h"
#import "GTMBase64.h"

@implementation DESCrypt

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key {
    NSData *encryptedData = [data DESEncryptedDataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    
    return encryptedData;
}



+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key{
    NSData *decryptedData = [data decryptedDESDataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    
    return decryptedData;
}


@end
