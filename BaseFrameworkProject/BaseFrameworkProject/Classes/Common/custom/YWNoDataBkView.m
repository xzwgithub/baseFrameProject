//
//  YWNoDataBkView.m
//  HY_Logistics_iOS
//
//  Created by DYL on 16/3/29.
//  Copyright © 2016年 DYL. All rights reserved.
//

#import "YWNoDataBkView.h"

#define WIDTH_SCALE 0.6

@implementation YWNoDataBkView

/**
*  设置没有数据的背景视图
*
*
*  @return 无数据的背景视图
*/
-(instancetype)initWithFrame:(CGRect)frame imageY:(CGFloat)imageY type:(NoDataType)noDataType{
    self = [super initWithFrame:frame];
    if(self){
        frame.origin.y = imageY;
        UIImageView *_myImageView = [[UIImageView alloc] initWithFrame:frame];
        _myImageView.contentMode = UIViewContentModeCenter;
        _myImageView.image = [UIImage imageNamed:(noDataType == NoDataTypeNodata)?@"nodata_zore":@"nodata_error"];
        [self addSubview:_myImageView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initSmolViewWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame type:(NoDataType)noDataType{
    
    self = [super initWithFrame:frame];
    if(self){
        UIImageView *_myImageView = [[UIImageView alloc] initWithFrame:imageFrame];
        _myImageView.contentMode = UIViewContentModeScaleAspectFit;
        _myImageView.image = [UIImage imageNamed:(noDataType == NoDataTypeNodata)?@"nodata_zore":@"nodata_error"];
        [self addSubview:_myImageView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
