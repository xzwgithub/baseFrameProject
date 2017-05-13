//
//  StoryboardUtil.m
//  LZCloudApp
//
//  Created by chewyong on 16/1/15.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "StoryboardUtil.h"

@implementation StoryboardUtil

+ (UIStoryboard *)storyboardWithName:(NSString *)stroyboardName{
    if (!stroyboardName || [stroyboardName length] == 0) {
        return nil;
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:stroyboardName bundle:nil];
    
    return storyboard;
}

+ (UIViewController *)storyboardInitialVCWithName:(NSString *)stroyboardName{
    if (!stroyboardName || [stroyboardName length] == 0) {
        return nil;
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:stroyboardName bundle:nil];
    UIViewController *viewController =[storyboard instantiateInitialViewController];

    return viewController;
}

+ (UIViewController *)storyboardVCWithName:(NSString *)stroyboardName identifier:(NSString *)storyboardId{
    if (!stroyboardName || [stroyboardName length] == 0 || !storyboardId || [storyboardId length] == 0) {
        return nil;
    }
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:stroyboardName bundle:nil];
    UIViewController *viewController =[storyboard instantiateViewControllerWithIdentifier:storyboardId];

    return viewController;
}


@end
