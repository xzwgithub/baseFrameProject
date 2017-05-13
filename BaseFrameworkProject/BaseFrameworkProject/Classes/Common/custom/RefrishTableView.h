//
//  RefrishTableView.h
//  LecShipper_iOS
//
//  Created by dyw on 16/11/22.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "YWNoDataBkView.h"//无数据

@interface RefrishTableView : UITableView

/**
 当前页数 default:10
 */
@property (nonatomic, assign) NSInteger pageNum;

/**
 当前条数 default:10
 */
@property (nonatomic, assign) NSInteger pageSize;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

/**
 当前刷新的状态

 @return YES:下拉刷新。NO:上拉加载更多
 */
- (BOOL)isRefrishDataSource;

/**
 还原pageNum参数
 */
- (void)resetPageNum;

/**
 设置下啦刷新

 @param refreshBack 刷新回调
 */
- (void)setRefreshheaderWith:(void(^)(void))refreshBack;

/**
 设置上啦加载

 @param loadMoreBack 加载回调
 */
- (void)setLoadMoreFooterWith:(void(^)(void))loadMoreBack;

/**
 停止刷新
 */
- (void)endRefrish;

/**
 自动刷新
 */
- (void)autoRefrish;

/**
 设置无数据时的视图

 @param type 类型
 */
- (void)setNoDateBackViewWith:(NoDataType)type;

/**
 设置footerView

 @param isNoMoreData 是否没有更多数据
 */
- (void)setNoMoreData:(BOOL)isNoMoreData;

@end
