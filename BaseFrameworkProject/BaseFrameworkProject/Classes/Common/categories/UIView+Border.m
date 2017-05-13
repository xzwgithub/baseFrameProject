//
//  UIView+Border.m
//  HY_Logistics_iOS
//
//  Created by DYL on 16/3/22.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

/**
 *  导圆角
 *
 *  @param calue 半径
 */
- (void)setRoundWithValue:(CGFloat)calue{
    [self.layer setCornerRadius:calue];
    self.layer.masksToBounds = YES;
}

/**
 *  圆形
 */
- (void)setRound{
    [self setRoundWithValue:self.frame.size.height/2];
}

@end
