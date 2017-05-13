//
//  NSDictionary+NativeJson.h
//  HY_Logistics_iOS
//
//  Created by 君若见故 on 16/3/4.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NativeJson)

+ (NSDictionary *)dictionaryWithNativeJsonFileName:(NSString *)name;

@end
