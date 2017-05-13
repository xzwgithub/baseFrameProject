//
//  UIView+Border.h
//  HY_Logistics_iOS
//
//  Created by DYL on 16/3/22.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

/**
 *  导圆角
 *
 *  @param calue 半径
 */
- (void)setRoundWithValue:(CGFloat)calue;

/**
 *  圆形
 */
- (void)setRound;

@end
