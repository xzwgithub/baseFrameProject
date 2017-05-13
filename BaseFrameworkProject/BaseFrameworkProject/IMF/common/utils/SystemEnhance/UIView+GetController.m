//
//  UIView+GetController.m
//  AmwayMCommerce
//
//  Created by issuser on 12-12-29.
//
//

#import "UIView+GetController.h"

@implementation UIView(GetController)

/**
 *get controller of a view
 */
- (UIViewController *)viewController {
//    for (UIView *v = self.superview; v; v=v.superview) {
//        UIResponder *nextResponder = [v nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
    UIResponder *responder = [self nextResponder];
    while (responder)
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


@end
