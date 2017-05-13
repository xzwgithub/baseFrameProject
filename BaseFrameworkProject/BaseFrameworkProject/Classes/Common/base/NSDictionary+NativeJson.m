//
//  NSDictionary+NativeJson.m
//  HY_Logistics_iOS
//
//  Created by 君若见故 on 16/3/4.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import "NSDictionary+NativeJson.h"

@implementation NSDictionary (NativeJson)

+ (NSDictionary *)dictionaryWithNativeJsonFileName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    if (path == nil) {
        return nil;
    }
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    //如果错误返回nil,否则返回正确结果
    return (error?nil:dic);
}

@end
