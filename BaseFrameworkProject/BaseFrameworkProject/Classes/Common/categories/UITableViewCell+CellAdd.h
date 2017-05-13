//
//  UITableViewCell+CellAdd.h
//  iSmartHome
//
//  Created by 柯旗 on 15/7/31.
//  Copyright (c) 2015年 柯旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CellAdd)

+ (UINib *)getNibFile;

+ (NSString *)getNibName;

+ (NSString *)identifier;
@end
