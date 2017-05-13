//
//  QRCodeResourceUtils.h
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/7.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QRCodeResourceUtils : NSObject

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;

+ (NSData *)wavDataFromCustomBundle:(NSString *)wavName;


@end
