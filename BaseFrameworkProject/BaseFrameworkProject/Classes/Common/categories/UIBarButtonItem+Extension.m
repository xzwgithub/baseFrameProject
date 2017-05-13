//
//  UIBarButtonItem+Extension.m
//  LZCloudApp
//
//  Created by jkenny on 15/7/28.
//  Copyright (c) 2015年 jkenny. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName addTarget:(id)target action:(SEL)sel{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    //设置按钮尺寸的大小为背景图片的大小
    CGRect rect = btn.frame;
    rect.size = btn.currentBackgroundImage.size;;
    btn.frame = rect;
    
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName titleName:(NSString *)titleName addTarget:(id)target action:(SEL)sel{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateHighlighted];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //设置按钮尺寸的大小为背景图片的大小
    CGRect rect = btn.frame;
    rect.size = CGSizeMake(80, 44);
    btn.frame = rect;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)itemWithTitleName:(NSString *)titleName {
    UILabel *lable = [[UILabel alloc] init];
    //设置按钮尺寸的大小为背景图片的大小
    lable.text = titleName;
    lable.frame = CGRectMake(0, 0, 150, 21);
    lable.font = [UIFont systemFontOfSize:19];
    lable.textColor = [UIColor whiteColor];
    return [[UIBarButtonItem alloc] initWithCustomView:lable];
}



@end
