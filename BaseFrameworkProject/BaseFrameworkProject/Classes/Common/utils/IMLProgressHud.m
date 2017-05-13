//
//  IMLProgressHud.m
//  ArchitectureTest
//
//  Created by keqi on 16/8/3.
//  Copyright © 2016年 iSoftStone. All rights reserved.
//

#import "IMLProgressHud.h"

#define kTimeoutSeconds 30.f
#define kLabelFont 16.f

@interface IMLProgressHud ()<MBProgressHUDDelegate>
{
    UITapGestureRecognizer *_hideHudGesture;
    BOOL _isHidden;  //是否已经隐藏
}
@property (nonatomic, strong) MBProgressHUD *hud;
@end
@implementation IMLProgressHud

#pragma mark - Initialization
static id gSharedInstance = nil;

+ (IMLProgressHud *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gSharedInstance = [[IMLProgressHud alloc] init];
    });
    return gSharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.openHiddenGesture = NO;  //默认关闭隐藏提示框的手势
        self.openTimeOutPrompt = NO;  //默认关闭超时提醒
    }
    return self;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!gSharedInstance) {
        gSharedInstance = [super allocWithZone:zone];
    }
    return gSharedInstance;
}


#pragma mark - Class Methods

+ (void)showHudWithText:(NSString *)textString toView:(UIView *)view
{
    [[IMLProgressHud sharedInstance] dismiss];
    [[IMLProgressHud sharedInstance] showHudWithText:textString toView:view];
}

+ (void)dismiss
{
    [[IMLProgressHud sharedInstance] dismiss];
}

+ (void)showHudWithText:(NSString *)textString toView:(UIView *)view duration:(NSTimeInterval)duration {
    
    [[IMLProgressHud sharedInstance] dismiss];
    [[IMLProgressHud sharedInstance] showHudWithText:textString toView:view duration:duration];
}

+ (void)showAutomicHiddenHudText:(NSString *)textString toView:(UIView *)view {
    
    [[IMLProgressHud sharedInstance] showHudWithText:textString toView:view duration:1.0f];
}

+ (void)showHudWithCustomView:(UIView *)customView toView:(UIView *)view {
    
    [[IMLProgressHud sharedInstance] showHudWithCustomView:customView toView:view];
}

#pragma mark - show & hide

- (void)hindOldHUD{
    if(_hud) {
        [_hud hide:YES];
        _hud = nil;
    }
}

- (void)showHudWithCustomView:(UIView *)customView toView:(UIView *)view  {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    [self hindOldHUD];
    
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.removeFromSuperViewOnHide = YES;
    
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = customView;
    self.hud.delegate = self;
    
    [self setHideHudGesture];
}

- (void)showHudWithText:(NSString *)textString toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hindOldHUD];
    
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.delegate = self;
    
    self.hud.detailsLabelFont = [UIFont boldSystemFontOfSize:kLabelFont];
    self.hud.detailsLabelText = textString;
    // 隐藏时候从父控件中移除
    self.hud.removeFromSuperViewOnHide = YES;
    
    [self setHideHudGesture];
    
    if (_openTimeOutPrompt) {  //开启超时提醒
        
        _isHidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTimeoutSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self handleTimeOut];
        });
    }
}

- (void)showHudWithText:(NSString *)textString toView:(UIView *)view duration:(NSTimeInterval)duration {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hindOldHUD];
    
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.removeFromSuperViewOnHide = YES;
    
    self.hud.detailsLabelFont = [UIFont boldSystemFontOfSize:kLabelFont];
    self.hud.detailsLabelText = textString;
    
    [self.hud hide:YES afterDelay:duration];
    
    [self setHideHudGesture];
}

- (void)handleTimeOut {
    
    if (!_isHidden) {
        
        _isHidden = YES;
        
        //提示超时
        [[self class] showHudWithText:NSLocalizedString(@"提示超时", nil) toView:nil duration:1.f];
    }
}

- (void)setHideHudGesture {
    
    if (_openHiddenGesture) {
        [self addHideHudGesture];
    } else {
        [self removeHideHudGesture];
    }
}

- (void)addHideHudGesture {
    
    if (!_hideHudGesture) {
        
        _hideHudGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    }
    
    [self.hud addGestureRecognizer:_hideHudGesture];
}

- (void)removeHideHudGesture {
    if (_hideHudGesture) {
        [self.hud removeGestureRecognizer:_hideHudGesture];
    }
}

- (void)dismiss {
    _isHidden = YES;
    
    [self.hud hide:YES];
    self.hud = nil;
}

- (void)dealloc {
    if (self.hud) {
        self.hud.delegate = nil;
    }
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    NSLog(@"hud was hidden");
    if (self.hudWasHiddenBlock) {
        self.hudWasHiddenBlock();
    }
}
@end
