//
//  DBHelper.h
//  SmartChargePal
//
//  Created by Wonder Chang on 15/9/6.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "DBConstants.h"

#ifndef __USEYTK__
#define __USEYTK__          1
#import "YTKKeyValueStore.h"    //如果不用此框架, 将__USEYTK__置为0 可删掉，并从Podfile中删掉
#endif

@interface DBHelper : NSObject

@property (strong, nonatomic) FMDatabaseQueue * dbQueue;
#if __USEYTK__
@property (strong, nonatomic) YTKKeyValueStore *store;
#endif

+ (DBHelper *)sharedInstance;

- (NSString *)dbPath;

- (void)inDatabase:(void(^)(FMDatabase *db))block;

- (void)doRefresh;

@end
