//
//  RootModel.h
//  HY_Logistics_iOS
//
//  Created by DYL on 16/2/23.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import "Entity.h"

@interface RootModel : Entity

/**
 *  返回码
 */
@property (nonatomic, assign) NSInteger rcode;
/**
 *  详情
 */
@property (nonatomic, copy) NSString *resultMsg;
/**
 *  获取字典数据
 */
@property (nonatomic, strong) NSDictionary *data;
/**
 *  获取的数组数据
 */
@property (nonatomic, strong) NSArray *dataList;
/**
 *  数据的条数
 */
@property (nonatomic, assign) NSInteger totalSize;

/**
 *  返回的数据(上传图片接口)
 */
@property (nonatomic, strong) NSDictionary *returnData;

@end
