//
//  UITabBar+Badge.h
//  HY_Logistics_iOS
//
//  Created by DYL on 16/7/21.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
