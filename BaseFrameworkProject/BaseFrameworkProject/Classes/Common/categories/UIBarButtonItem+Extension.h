//
//  UIBarButtonItem+Extension.h
//  LZCloudApp
//
//  Created by jkenny on 15/7/28.
//  Copyright (c) 2015年 jkenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName addTarget:(id)target action:(SEL)sel;

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName titleName:(NSString *)titleName addTarget:(id)target action:(SEL)sel;

+ (UIBarButtonItem *)itemWithTitleName:(NSString *)titleName;

@end
