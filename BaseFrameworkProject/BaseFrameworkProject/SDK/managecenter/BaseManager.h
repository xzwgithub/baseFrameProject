//
//  BaseManager.h
//  HY_Logistics_iOS
//
//  Created by DYL on 16/2/17.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UrlHeader.h"//请求地址
#import "HttpClientComponent.h"//请求对象
#import "RootModel.h"//根实体
#import "NSDictionary+NativeJson.h"//读取本地json文件
#import "AppConstants.h"

#pragma mark - ===================宏定义===================
/**
 *  请求成功回调
 *
 *  @param model 对应的实体
 */
typedef void(^SuccesBlock)(id model, NSInteger totalSize);

/**
 *  请求失败回调
 *
 *  @param errorCode       错误码
 *  @param errorDirections 错误说明
 */
typedef void(^FailureBlock)(NSInteger errorCode, NSString *errorDirections);

@interface BaseManager : NSObject

@end
