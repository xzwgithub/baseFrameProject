//
//  BaseBiz.h
//  UniversalArchitecture
//
//  Created by 张 黎 on 13-4-24.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
#import "LanguageRes.h"
#import "HttpClientComponent.h"
#import "Entity.h"
#import "Utils.h"
#import "ISSLog.h"


@interface BaseBiz : NSObject {
    void (^completionBlock)(id resp);
    void (^failedErrorBlock)(NSString *resultMsg);
}

- (void)clearBlock;
- (void)requestFinished:(HttpClientComponent *)httpClientComponent;
- (void)requestFailed:(HttpClientComponent *)httpClientComponent;

@end
