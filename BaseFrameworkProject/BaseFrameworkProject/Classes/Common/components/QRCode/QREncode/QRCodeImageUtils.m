//
//  QRCodeImageUtils.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/7.
//  Copyright © 2015年 zhangli. All rights reserved.
//

#import "QRCodeImageUtils.h"

#define FRONT_IMAGE_SCALE 7

@implementation QRCodeImageUtils

+ (UIImage *)addImage:(UIImage *)frontImage toImage:(UIImage *)backgroundImage {
    UIGraphicsBeginImageContext(backgroundImage.size);
    
    // Draw image1
    [backgroundImage drawInRect:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
    
    // Draw image2
    [frontImage drawInRect:CGRectMake((backgroundImage.size.width-backgroundImage.size.width/FRONT_IMAGE_SCALE)/2, (backgroundImage.size.height-backgroundImage.size.height/FRONT_IMAGE_SCALE)/2, backgroundImage.size.width/FRONT_IMAGE_SCALE, backgroundImage.size.height/FRONT_IMAGE_SCALE)];
    
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

@end
