//
//  StoryboardUtil.h
//  LZCloudApp
//
//  Created by chewyong on 16/1/15.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoryboardUtil : NSObject

/*!
 *  @method storyboardWithName
 *
 *  @param stroyboardName  storyboard名称，.stroyboard前的字符串
 *  @retrun UIStoryboard  storyboard对象
 *  @discussion  通过名称获取storyboard对象
 */
+ (UIStoryboard *)storyboardWithName:(NSString *)stroyboardName;


/*!
 *  @method storyboardWithName
 *
 *  @param stroyboardName  storyboard名称，.stroyboard前的字符串
 *  @retrun UIViewController  控制器对象
 *  @discussion  通过名称获取storyboard 入口的控制器
 */
+ (UIViewController *)storyboardInitialVCWithName:(NSString *)stroyboardName;


/*!
 *  @method storyboardVCWithName:viewControllerName:
 *
 *  @param stroyboardName  storyboard名称，.stroyboard前的字符串
 *  @param storyboardId storyboard标示，用于获取storyboard中的控制器
 *  @retrun UIViewController  控制器对象
 *  @discussion  通过stroyboardName和storyboardId获取指定的控制器
 */
+ (UIViewController *)storyboardVCWithName:(NSString *)stroyboardName identifier:(NSString *)storyboardId;

@end
