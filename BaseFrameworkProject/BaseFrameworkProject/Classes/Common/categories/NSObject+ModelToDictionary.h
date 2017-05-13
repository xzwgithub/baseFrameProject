//
//  NSObject+ModelToDictionary.h
//  LecShipper_iOS
//
//  Created by iwevon on 2016/11/29.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelToDictionary)
/**
 *  模型转字典
 *
 *  @return 字典
 */
- (NSDictionary *)dictionaryFromModel;

/**
 *  带model的数组或字典转字典
 *
 *  @param object 带model的数组或字典转
 *
 *  @return 字典
 */
- (id)idFromObject:(nonnull id)object;

@end
