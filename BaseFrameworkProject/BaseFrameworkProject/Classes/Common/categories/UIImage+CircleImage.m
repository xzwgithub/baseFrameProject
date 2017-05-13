//
//  UIImage+CircleImage.m
//  LecShipper_iOS
//
//  Created by issuser on 16/8/13.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

/** 设置圆形图片 */
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
