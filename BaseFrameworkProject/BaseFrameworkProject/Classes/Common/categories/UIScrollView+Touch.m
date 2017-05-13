//
//  UIScrollView+Touch.m
//  IpTop
//
//  Created by iOS on 15/10/21.
//  Copyright © 2015年 iOS. All rights reserved.
//

#import "UIScrollView+Touch.h"

@implementation UIScrollView (Touch)

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    static UIEvent *e = nil;
//    
//    if (e != nil && e == event) {
//        e = nil;
//        return [super hitTest:point withEvent:event];
//    }
//    
//    e = event;
//    
//    if (event.type == UIEventTypeTouches) {
//        NSSet *touches = [event touchesForView:self];
//        UITouch *touch = [touches anyObject];
//        if (touch.phase == UITouchPhaseBegan) {
//            
//            [self endEditing:YES];
//        }else if(touch.phase == UITouchPhaseEnded){
//            NSLog(@"Touches Ended");
//            
//        }else if(touch.phase == UITouchPhaseCancelled){
//            NSLog(@"Touches Cancelled");
//            
//        }else if (touch.phase == UITouchPhaseMoved){
//            NSLog(@"Touches Moved");
//            
//        }
//    }
//    return [super hitTest:point withEvent:event];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}


@end
