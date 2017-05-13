//
//  ZWCustomBtn.m
//  LecShipper_iOS
//
//  Created by xzw on 17/1/11.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "ZWCustomBtn.h"

#define TitleColor  [UIColor colorWithRed:81/255.0 green:154/255.0 blue:247/255.0 alpha:1.0]

@implementation ZWCustomBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self setTitleColor:TitleColor forState:UIControlStateNormal];
    [self setNeedsDisplay];
}


-(void)setColor:(UIColor *)color
{
    lineColor = [color copy];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextSetStrokeColorWithColor(contextRef,TitleColor.CGColor);
    
    if ([lineColor isKindOfClass:[UIColor class]]) {
        
        CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+2);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+2);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
