//
//  UIButton+Attributed.m
//  HY_Logistics_iOS
//
//  Created by DYL on 16/2/22.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import "UIButton+Attributed.h"

@implementation UIButton (Attributed)

- (void)setLineTitleWithColor:(UIColor *)textColor{
    //设置button下划线
    NSMutableAttributedString *registStr = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSRange strRangeR = {1,[registStr length]-2};
   // [registStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:strRangeR];  //设置颜色
    [registStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRangeR];
    [registStr addAttribute:NSUnderlineColorAttributeName value:textColor range:strRangeR];
    [self setAttributedTitle:registStr forState:UIControlStateNormal];
}

-(void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType
{
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    [self.imageView setContentMode:UIViewContentModeCenter];
    self.imageView.frame = CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    [self setImage:image forState:stateType];
    [self.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.titleLabel.frame = CGRectMake(self.frame.size.width - titleSize.width, 0, titleSize.width, titleSize.height);
    [self setTitle:title forState:stateType];
    
    
}








@end
