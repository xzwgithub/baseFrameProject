//
//  UITableViewCell+CellAdd.m
//  iSmartHome
//
//  Created by 柯旗 on 15/7/31.
//  Copyright (c) 2015年 柯旗. All rights reserved.
//

#import "UITableViewCell+CellAdd.h"

@implementation UITableViewCell (CellAdd)


+ (UINib *)getNibFile {
    
    return [UINib nibWithNibName:[self identifier] bundle:nil];
}

+ (NSString *)getNibName {
    
    return [self identifier];
}

+ (NSString *)identifier {
    
    return NSStringFromClass([self class]);
}
@end
