//
//  BaseViewController.m
//  Sparrow
//
//  Created by issuser on 13-11-21.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//
#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "YWNoDataBkView.h"
#import "IQKeyboardManager.h"


static const CGFloat kLabelFontSize = 18.f;
static const CGFloat kMesageLabelFontSize = 17.f;
@implementation LoadingView

@synthesize spinner;

- (void)dealloc{
    ISS_RELEASE(spinner);
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        UIView *_blockerView = ISS_AUTORELEASE([[UIView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)]);
        _blockerView.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];
        //_blockerView.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0-36);
        _blockerView.alpha = 1.0;
        _blockerView.clipsToBounds = YES;
        [_blockerView.layer setCornerRadius:10];
        //if ([_blockerView.layer respondsToSelector: @selector(setCornerRadius:)])
            //[(id) _blockerView.layer setCornerRadius: 10];
        self.spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        self.spinner = ISS_AUTORELEASE([[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge]);
        
        //spinner.center = CGPointMake(_blockerView.bounds.size.width / 2, _blockerView.bounds.size.height / 2 + 10);
        spinner.center = CGPointMake(_blockerView.bounds.size.width / 2, _blockerView.bounds.size.height / 2);
        [_blockerView addSubview: spinner];
        [spinner startAnimating];

        _blockerView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        //NSLog(@"_blockerView.center:%@",NSStringFromCGPoint(_blockerView.center));
        [self addSubview:_blockerView];
        isBlock =YES;
        
    }
    return self;
}



@end



@interface BaseViewController () <UITextFieldDelegate>

@property(nonatomic,strong)MBProgressHUD *blockView;

@property(nonatomic,strong)UIWindow *blockWindow;

@property (nonatomic, strong)UIImageView *navLinBk;

//阻塞背景视图
@property (nonatomic, strong) UIView *blockBgView;
//提示框
@property (nonatomic, retain) UIView *toastBgView;
@property (nonatomic, assign) BOOL isHindHud;

@end

@implementation BaseViewController
@synthesize blockView,blockWindow,blockBgView,toastBgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"初始化--->%@", NSStringFromClass(self.class));
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        NSLog(@"初始化--->%@", NSStringFromClass(self.class));
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = ZDCL_NOMOL_BK;
        NSLog(@"初始化--->%@", NSStringFromClass(self.class));
    }
    return self;
}

- (void)dealloc{
    NSLog(@"销毁--->%@", NSStringFromClass(self.class));
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _isHindHud = YES;
    [IMLProgressHud dismiss];
    [self hindKeyBoard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    
}

- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self hindKeyBoard];
}

//加载loading动画
- (void)showLoadingWith:(NSString *)text toView:(UIView *)view {
    if (_isHindHud) return;
    if (text.length) {
        [IMLProgressHud showHudWithText:text toView:view];
    } else {
        if (!blockView) {
            blockView = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    }
//    [[IMLProgressHud sharedInstance]setPromptViewLevel:2];
//    [IMLProgressHud showHudWithText:text];
    
}

//移除loading动画

//修改statusbar上面加了windows loading去不掉的问题

- (void)hideLoading {
    _isHindHud = NO;
    [IMLProgressHud dismiss];
    [blockView hide:YES];
    blockView = nil;//xzw
}


-(void)showMBProgressHUD:(NSString *)message{
    if (_isHindHud) return;
    if ([message length] > 12) {
        [self showToastWithTitle:@"" message:message];
    }else{
        //只显示文字
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = 5;
        hud.labelText = message;
        
        //hud.size = CGSizeMake(self.view.frame.size.width/2, 300);
        hud.margin = 10.f;
        hud.yOffset = -20.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}


//设置阻塞背景图
-(void)addBlockBgView{
    if (blockBgView == nil) {
        CGRect frame = self.view.bounds;
        frame.origin.y = 64;
        frame.size.height = frame.size.height - 64;
        self.blockBgView = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:blockBgView];
    }else{
        [self.blockBgView setHidden:NO];
    }
}

//弹提示
- (void)showToastWithTitle:(NSString *)title message:(NSString *)message {
    [self addBlockBgView];
    
    if (toastBgView == nil) {  //初始化toast背景
        self.toastBgView = [[UIView alloc] init];
        toastBgView.layer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.8] CGColor];
        [toastBgView.layer setCornerRadius: 10.0];
        toastBgView.clipsToBounds = YES;
        toastBgView.alpha = 0.0;
        [blockBgView addSubview:toastBgView];
    }else{
        for (UIView *view in [self.toastBgView subviews]) {
            [view removeFromSuperview];
        }
        [self.toastBgView setHidden:NO];
    }
    //边距
    float margin = 5.0;
    float margin_y = 5.0;
    float maxWidth = 240.0;
    float maxHeight = 380.0;
    float height = 0.0;
    UILabel *titleLabel = nil; CGSize labelSize;
    //标题label
    if ([title length]>0) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.adjustsFontSizeToFitWidth = NO;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = NSIntegerMax;
        titleLabel.opaque = NO;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
        titleLabel.text = title;
        [toastBgView addSubview:titleLabel];
        height += 10;
        labelSize = [titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:kLabelFontSize] constrainedToSize:CGSizeMake(maxWidth - 4 * margin, maxHeight)];
        height += labelSize.height;
        titleLabel.frame = CGRectMake(margin, 14, maxWidth-2*margin_y, labelSize.height);
    }
    if (height==0.0) {
        height += 10.0;
    }
    else {
        height += 20.0;
    }
    //内容label
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.adjustsFontSizeToFitWidth = NO;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.opaque = NO;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = NSIntegerMax;
    messageLabel.lineBreakMode = NSLineBreakByCharWrapping;// 不可少Label属性之二
    messageLabel.font = [UIFont systemFontOfSize:kMesageLabelFontSize];
    messageLabel.text = message;
    [toastBgView addSubview:messageLabel];
    labelSize = [messageLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:kMesageLabelFontSize] constrainedToSize:CGSizeMake(maxWidth - 4 * margin, maxHeight)];
    messageLabel.frame = CGRectMake(margin, height, maxWidth-2*margin_y, labelSize.height);
    
    height += labelSize.height;
    
    height += 10.0;//74;
    
    toastBgView.frame = CGRectMake(0, 0, maxWidth, height);
    toastBgView.center = CGPointMake(self.blockBgView.center.x, self.view.frame.size.height*2/3);
    
    //动画
    [UIView animateWithDuration:0.30 animations:^{
        toastBgView.alpha = 1.0f;
    }];
    
    [self performSelector:@selector(removeDelayed:) withObject:toastBgView afterDelay:2.0];
}

- (void)removeDelayed:(UIView *)view {
    //移除动画
    [UIView animateWithDuration:0.30 animations:^{
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [toastBgView setHidden:YES];
        [blockBgView setHidden:YES];
    }];
}


- (AppDelegate *)appDelegate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (FailedErrorBlock)failedBlock {
    if (!_failedBlock) {
        __weak __typeof(self)weakSelf = self;
        _failedBlock = ^(NSString *resultMsg) {
            [weakSelf hideLoading];
            [IMLProgressHud showAutomicHiddenHudText:resultMsg toView:nil];
        };
    }
    return _failedBlock;
}


- (UIView *)noDataViewWithTitle:(NSString *)title {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, (SCREEN_HEIGHT-64-49-88)/2, SCREEN_WIDTH, 88.0)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.opaque = NO;
    
    headerLabel.textColor = UIColorFromRGB(0x8a7262);
    
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    
//    headerLabel.font = [UIFont systemFontOfSize:17.];
    CGRect frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 44.0);
    frame.origin.x = 10;
    frame.size.width = SCREEN_WIDTH-frame.origin.x;
    headerLabel.frame = frame;
    
    headerLabel.text = title;//@"加载失败，请重试"
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    [customView addSubview:headerLabel];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((SCREEN_WIDTH-64)/2, 48, 64, 37);
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    [button setBackgroundColor:[Utils colorWithHexString:@"#ff543b"]];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:button];
    
    return customView;
}

- (void)buttonClicked:(id)sender {
    if (_retryBlock) {
        _retryBlock();
    }
}

- (UIView *)noDataViewNoButtonWithTitle:(NSString *)title {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, (SCREEN_HEIGHT-64-49-44)/2, SCREEN_WIDTH, 44.0)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.opaque = NO;
    
    headerLabel.textColor = UIColorFromRGB(0x8a7262);
    
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    
    //    headerLabel.font = [UIFont systemFontOfSize:17.];
    CGRect frame = customView.bounds;
    frame.origin.x = 10;
    frame.size.width = SCREEN_WIDTH-frame.origin.x;
    headerLabel.frame = frame;
    
    headerLabel.text = title;//@"加载失败，请重试"
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    [customView addSubview:headerLabel];
    
    
    return customView;
}

- (UIImageView *)navLinBk{
    if (!_navLinBk && [self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            _navLinBk = [self linkView:obj];
        }
    }
    return _navLinBk;
}


- (UIImageView *)linkView:(id)obj{
    
    if ([obj isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView=(UIImageView *)obj;
        NSArray *list2=imageView.subviews;
        for (id obj2 in list2) {
            if ([obj2 isKindOfClass:[UIImageView class]]) {
                return (UIImageView *)obj2;
            }
        }
    }
    return nil;
}



/**
 *  隐藏键盘
 */
- (void)hindKeyBoard{
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}


//隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self hindKeyBoard];
}

#pragma mark - ==================== 懒加载区域 ==========================
/**
 *  下拉刷新
 */
- (MJRefreshGifHeader *)header{
    if(!_header){
        __weak __typeof(self)weakSelf = self;
        _header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            !weakSelf.refreshBlock?: weakSelf.refreshBlock();
        }];
    }
    return _header;
}

/**
 *  上拉加载更多
 */
- (MJRefreshBackNormalFooter *)footer{
    if(!_footer){
        __weak __typeof(self)weakSelf = self;
        _footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            !weakSelf.lodingBlock?:weakSelf.lodingBlock();
        }];
        [_footer setTitle:@"没有更多数据了!" forState:MJRefreshStateNoMoreData];
    }
    return _footer;
}

/**
 *  设置tableView 没有数据时候的View
 *
 *   */
- (void)setTableViewNodataImage:(BOOL)isNOdata withDataSorce:(NSArray *)dataSource atTableView:(UITableView *)tableView{
    if(!dataSource.count){
        YWNoDataBkView *noDataBkView = [[YWNoDataBkView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-40) imageY:10 type:isNOdata?NoDataTypeNodata:NoDataTypeNetError];
        tableView.backgroundView = noDataBkView;
    }
    else{
        tableView.backgroundView = nil;
    }
}

-(LoginAccountManager *)loginAccountManager
{
    if (!_loginAccountManager) {
        
        _loginAccountManager = [LoginAccountManager shareAccountManager];
    }
    return _loginAccountManager;
}


@end
