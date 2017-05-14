//
//  UIBarButtonItem+Extension.h
//  XNWBDemo
//
//  Created by xzw on 16/10/31.
//  Copyright © 2016年 xzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString*)image highImage:(NSString*)highImage;

@end
