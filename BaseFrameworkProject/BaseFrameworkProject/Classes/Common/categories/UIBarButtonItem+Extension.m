//
//  UIBarButtonItem+Extension.m
//  XNWBDemo
//
//  Created by xzw on 16/10/31.
//  Copyright © 2016年 xzw. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGSize imageSize = backBtn.currentBackgroundImage.size;
    backBtn.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    UIBarButtonItem * itemBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    return itemBtn;
}

@end
