//
//  YWNoDataBkView.h
//  HY_Logistics_iOS
//
//  Created by DYL on 16/3/29.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 无数据的类型
 */
typedef enum : NSUInteger {
    NoDataTypeNodata = 0,//没有数据
    NoDataTypeNetError  //请求失败
} NoDataType;

@interface YWNoDataBkView : UIView

/**
 *  设置没有数据时的背景
 *
 *  @param frame      大小位置
 *  @param imageY     图片的Y
 *  @param noDataType 无数据的类型
 *
 *  @return View
 */

-(instancetype)initWithFrame:(CGRect)frame imageY:(CGFloat)imageY type:(NoDataType)noDataType;

-(instancetype)initSmolViewWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame type:(NoDataType)noDataType;

@end
