//
//  DES.h
//  UniversalArchitecture
//
//  Created by issuser on 13-1-8.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@interface DES : NSObject

+ (NSString*)TripleDES:(NSString*)plainText
      encryptOrDecrypt:(CCOperation)encryptOrDecrypt
                   key:(NSString*)key;

@end
