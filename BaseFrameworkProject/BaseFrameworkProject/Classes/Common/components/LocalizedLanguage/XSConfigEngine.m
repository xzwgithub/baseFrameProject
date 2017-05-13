//
//  XSConfigEngine.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/18.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import "XSConfigEngine.h"

@implementation XSConfigEngine


+ (void)sysConfigSetInt:(NSInteger)value forKey:(NSString *)key
{
    if (!key || key.length == 0)
    {
        return ;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSInteger)sysConfigGetIntForKey:(NSString *)key
{
    if (!key || key.length == 0)
    {
        return -1;
    }
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}


@end
