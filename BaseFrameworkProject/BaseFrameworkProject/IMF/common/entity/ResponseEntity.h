//
//  ResponseEntity.h
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import "Entity.h"

@interface ResponseEntity : Entity

@property (assign, nonatomic) NSInteger rcode;
@property (strong, nonatomic) NSString *resultMsg;
@property (assign, nonatomic) NSInteger totalSize;  //总条数
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSArray *dataList;

@end
