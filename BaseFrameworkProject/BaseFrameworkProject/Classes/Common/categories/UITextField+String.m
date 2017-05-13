//
//  UITextField+String.m
//  LecShipper_iOS
//
//  Created by iSoftStone on 2016/12/7.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import "UITextField+String.h"

@implementation UITextField (String)

- (BOOL)inputToUppercaseByRange:(NSRange)range replacementString:(NSString *)string {
    
    char commitChar = [string characterAtIndex:0];
    if (commitChar > 96 && commitChar < 123) {
        //小写变成大写
        NSString * uppercaseString = string.uppercaseString;
        NSString * str1 = [self.text substringToIndex:range.location];
        NSString * str2 = [self.text substringFromIndex:range.location];
        self.text = [NSString stringWithFormat:@"%@%@%@",str1,uppercaseString,str2];
        return NO;
    }
    return YES;
}


@end
