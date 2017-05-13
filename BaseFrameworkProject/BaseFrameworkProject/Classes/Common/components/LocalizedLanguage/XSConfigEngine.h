//
//  XSConfigEngine.h
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/18.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XSConfigEngine : NSObject

/**
 set value for key
 @param  value key
 @return nil
 */
+ (void)sysConfigSetInt:(NSInteger)value forKey:(NSString *)key;

/**
 get value with key
 @param  key
 @return nil
 */
+ (NSInteger)sysConfigGetIntForKey:(NSString *)key;


@end
