//
//  UIButton+Attributed.h
//  HY_Logistics_iOS
//
//  Created by DYL on 16/2/22.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Attributed)

- (void)setLineTitleWithColor:(UIColor *)textColor;

-(void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

@end
