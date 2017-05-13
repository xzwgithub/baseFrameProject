//
//  QRCodeResourceUtils.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/7.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import "QRCodeResourceUtils.h"

@implementation QRCodeResourceUtils

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"QRScan.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
}

+ (NSData *)wavDataFromCustomBundle:(NSString *)wavName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"QRScan.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *wav_path = [bundle pathForResource:wavName ofType:@"wav"];
    NSData* data = [[NSData alloc] initWithContentsOfFile:wav_path];
    
    return data;
}


@end
