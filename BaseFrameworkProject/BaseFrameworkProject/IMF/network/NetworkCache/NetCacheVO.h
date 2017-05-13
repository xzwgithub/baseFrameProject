//
//  NetCacheVO.h
//  MISUniversalECommerce
//
//  Created by issuser on 13-9-16.
//  Copyright (c) 2013年 lizhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISSARC.h"

@interface NetCacheVO : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *req;
@property (nonatomic, assign) long long reqTime;
@property (nonatomic, retain) NSString *resp;
@property (nonatomic, assign) long long respTime;

- (NSString *)toString;

@end
