//
//  RefrishTableView.m
//  LecShipper_iOS
//
//  Created by dyw on 16/11/22.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import "RefrishTableView.h"


//默认PageNum
static NSInteger const kRefrishTableViewPageNum     = 1;
static NSInteger const kRefrishTableViewpageSize    = 10;


@interface RefrishTableView ()

/**
 *  下拉刷新回调
 */
@property (nonatomic, copy) void (^refreshBlock)();
/**
 *  上拉加载回调
 */
@property (nonatomic, copy) void (^loadBlock)();

//MJ
/**
 *  下拉刷新
 */
@property (nonatomic, strong) MJRefreshGifHeader *mjHeader;

/**
 *  上拉加载更多
 */
@property (nonatomic, strong) MJRefreshBackNormalFooter *mjFfooter;

@end

@implementation RefrishTableView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        self.dataSourceArr = [NSMutableArray array];
        self.pageNum = kRefrishTableViewPageNum;
        self.pageSize = kRefrishTableViewpageSize;
        CGRect frame=CGRectMake(0, 0, 0,CGFLOAT_MIN);
        self.tableHeaderView = [[UIView alloc]initWithFrame:frame];
    }
    return self;
}

-(void)reloadData{
    [super reloadData];
    //1.stop refresh
    [self endRefrish];
    //2.setup backgroundView
    if(self.dataSourceArr.count){
        self.backgroundView = nil;
    } else {
        YWNoDataBkView *noDateBkView = [[YWNoDataBkView alloc]initWithFrame:self.bounds imageY:0 type:NoDataTypeNodata];
        self.backgroundView = noDateBkView;
    }
}

- (BOOL)isRefrishDataSource {
    
    return self.pageNum == kRefrishTableViewPageNum;
}

- (void)resetPageNum {
    self.pageNum = kRefrishTableViewPageNum;
}


- (void)setRefreshheaderWith:(void(^)(void))refreshBack{
    self.refreshBlock = [refreshBack copy];
    self.header = self.mjHeader;
}

- (void)setLoadMoreFooterWith:(void(^)(void))loadMoreBack{
    self.loadBlock = [loadMoreBack copy];
    self.footer = self.mjFfooter;
}

/**
 停止刷新
 */
- (void)endRefrish{
    if(_mjFfooter && [_mjFfooter isRefreshing]){
        [_mjFfooter endRefreshing];
    }
    if(_mjHeader && [_mjHeader isRefreshing]){
        [_mjHeader endRefreshing];
    }
}

/**
 自动刷新
 */
- (void)autoRefrish{
    if(_mjHeader){
        [_mjHeader beginRefreshing];
    }
}

/**
 设置无数据时的视图
 
 @param type 类型
 */
- (void)setNoDateBackViewWith:(NoDataType)type{
    [self.dataSourceArr removeAllObjects];
    [self reloadData];
    YWNoDataBkView *noDateBkView = [[YWNoDataBkView alloc]initWithFrame:self.bounds imageY:0 type:type];
    self.backgroundView = noDateBkView;
}

/**
 设置footerView
 
 @param isNoMoreData 是否没有更多数据
 */
- (void)setNoMoreData:(BOOL)isNoMoreData{
    isNoMoreData?[self.mjFfooter endRefreshingWithNoMoreData]:[self.mjFfooter resetNoMoreData];
}


#pragma mark - Lazy

- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

#pragma mark - ==================== 懒加载区域 ==========================
/**
 *  下拉刷新
 */
- (MJRefreshGifHeader *)mjHeader{
    if(!_mjHeader){
        __weak __typeof(self)weakSelf = self;
        _mjHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = kRefrishTableViewPageNum;
            !weakSelf.refreshBlock?: weakSelf.refreshBlock();
        }];
    }
    return _mjHeader;
}

/**
 *  上拉加载更多
 */
- (MJRefreshBackNormalFooter *)mjFfooter{
    if(!_mjFfooter){
        __weak __typeof(self)weakSelf = self;
        _mjFfooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageNum++;
            !weakSelf.loadBlock?:weakSelf.loadBlock();
        }];
        [_mjFfooter setTitle:@"没有更多数据了!" forState:MJRefreshStateNoMoreData];
    }
    return _mjFfooter;
}

@end
