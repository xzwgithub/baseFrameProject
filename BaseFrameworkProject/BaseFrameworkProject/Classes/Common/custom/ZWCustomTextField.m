//
//  ZWCustomTextField.m
//  BaseFrameworkProject
//
//  Created by xzw on 17/5/13.
//  Copyright © 2017年 xzw. All rights reserved.
//

#import "ZWCustomTextField.h"

@implementation ZWCustomTextField

//控制还未输入时文本的位置，缩进10
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 8, 0);
}

//控制输入后文本的位置，缩进10
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 8, 0);
}

@end
