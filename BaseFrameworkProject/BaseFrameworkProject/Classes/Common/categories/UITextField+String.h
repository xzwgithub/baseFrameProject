//
//  UITextField+String.h
//  LecShipper_iOS
//
//  Created by iSoftStone on 2016/12/7.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (String)

/** 输入转大写字母
    - (BOOL)textField:shouldChangeCharactersInRange:replacementString:
 */
- (BOOL)inputToUppercaseByRange:(NSRange)range replacementString:(NSString *)string;

@end
