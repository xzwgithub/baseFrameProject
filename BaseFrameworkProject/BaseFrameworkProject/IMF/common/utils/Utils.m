//
//  Utils.m
//  UniversalArchitecture
//
//  Created by issuser on 12-10-30.
//  Copyright (c) 2012年 isoftstone. All rights reserved.
//

#import "Utils.h"
#import "MBProgressHUD.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

@implementation Utils

+ (NSString *)uuid {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    //NSLog(@"uuid %@",result);
    //2015.6.15 转换小写
    result = [result lowercaseString];
    return result;
}

+ (NSString *)timeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:ISS_AUTORELEASE([[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"])];
    //    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDateString = [formatter stringFromDate:[NSDate date]];
    ISS_RELEASE(formatter);
    //NSLog(@"newDateString %@",newDateString);
    
    return newDateString;
}

/**
 *返回从 UTC 1970 年 1 月 1 日午夜开始经过的毫秒数
 */
+ (long long)currentTimeMillis {
    return [[NSDate date] timeIntervalSince1970]*1000;
}

/**
 *Toast消息提示框
 */
+ (void)showToastWihtMessage:(NSString *)message {
    
    if (!message.length) { return; }
    //避免显示延时,需要切换到主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow *mainView = [[UIApplication sharedApplication] keyWindow];
        MBProgressHUD *alert = nil;
        for (UIView *tipVieww in mainView.subviews) {
            if ([tipVieww isKindOfClass:[MBProgressHUD class]]) {
                alert = (MBProgressHUD *)tipVieww;
            }
        }
        
        if (alert == nil) {
            alert = [MBProgressHUD showHUDAddedTo:mainView animated:YES];
            alert.yOffset += alert.frame.size.height*0.3;
        }
        
        alert.labelText = message;
        alert.margin = 10.0f;
        alert.cornerRadius = 8.0f;
        
        alert.labelFont = [UIFont systemFontOfSize:17.0f];
        alert.mode = MBProgressHUDModeText;
        alert.removeFromSuperViewOnHide = YES;
        [alert show:YES];
        [alert hide:YES afterDelay:2.0];
    });
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"r:%d g:%d b:%d",r, g, b);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSString *)appVersion {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *appVersion = nil;
    NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
    if (marketingVersionNumber && developmentVersionNumber) {
        if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
            appVersion = marketingVersionNumber;
        } else {
            appVersion = [NSString stringWithFormat:@"%@.%@",marketingVersionNumber,developmentVersionNumber];
        }
    } else {
        appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
    }
    return appVersion;
}

+ (NSString *)bundleIdentifier {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    //NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}

//判断iPhone是否联网状态

+ (BOOL)isNetworkReachable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSString *)netType {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NSString *netType = @"";
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        
        netType = @"";
        
    }else{
        int n = [num intValue];
        //NSLog(@"dataNetworkType:%d",n);
        if (n == 0) {
            netType = @"";
        }else if (n == 1){
            netType = @"2g";
        }else if (n == 2){
            netType = @"3g";
        }else{
            netType = @"wifi";
        }
        
    }
    
    return netType;
}


+ (NSString *)weekStringByFormatDateString:(NSString *)string
{
    NSDateFormatter *formatter = ISS_AUTORELEASE([[NSDateFormatter alloc] init]);
    //首先转为 NSDate
//    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
    formatter.locale = ISS_AUTORELEASE([[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]);
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSRange range = [string rangeOfString:@" "];
    NSDate *date = [formatter dateFromString:[string substringToIndex:range.location]];
//    NSLog(@"date:%@",date);

    //转换为带星期的字符串
    [formatter setDateFormat:@"EEEE MM/dd/yyyy"];
    NSString *newDateString = [formatter stringFromDate:date];
    return newDateString;
}
+ (NSString *)stringByFormatDateString:(NSString *)string {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //首先转为 NSDate
//    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss aaa"];
//    NSDate *date = [formatter dateFromString:string];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSRange range = [string rangeOfString:@" "];
    NSDate *date = [formatter dateFromString:[string substringToIndex:range.location]];
    //NSLog(@"date:%@",date);
    
    //转换的日期字符串
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *newDateString = [formatter stringFromDate:date];
    ISS_RELEASE(formatter);
    
    return newDateString;
}

/** 颜色 */
#define BASE_BG_COLOR @"#ededed"
#define BASE_GREEN_COLOR @"#00b181"
#define BASE_LIGHT_GRAY_COLOR @"b3b3b3"
#define BASE_GRAY_COLOR @"b2b2b2"
#define BASE_DARK_COLOR @"000000"

//创建导航条
+ (UIView *)createTitleView:(NSString *)title leftName:(NSString *)left rightName:(NSString *)right target:(id)sel
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //标题背景
    titleView.backgroundColor = [self colorWithHexString:BASE_BG_COLOR];
    UILabel *linerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
    [linerLabel setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:linerLabel];
    //图片
    UIImageView *leftRedArrow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 21, 21)];
    [leftRedArrow setImage:[UIImage imageNamed:@"left_back_arr.png"]];
    [titleView addSubview:leftRedArrow];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(leftRedArrow.frame.origin.x + 13 , 0, 44, 44)];
    [backBtn setTitle:left forState:UIControlStateNormal];
    [backBtn.titleLabel setTextColor:[self colorWithHexString:BASE_GREEN_COLOR]];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [backBtn setTitleColor:[self colorWithHexString:BASE_GREEN_COLOR] forState:UIControlStateNormal];
    [backBtn addTarget:sel action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backBtn];
    if ([title length]>0) {
        CGFloat titlelength = [self caculateTextLengt:title FontSize:18 withWidth:1000 WithHight:21];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(320/2 - titlelength/2, 11, titlelength, 21)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setText:title];
        [titleLabel setTag:101];
        [titleLabel setFont:[UIFont systemFontOfSize:17]];
        [titleView addSubview:titleLabel];
    }
    //根据标题长度改变宽
    if ([right length]>0) {
        CGFloat rightlength = [self caculateTextLengt:right FontSize:17 withWidth:1000 WithHight:21];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(305 - rightlength, 0, 44, 44)];
        [rightBtn setTitle:right forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [rightBtn.titleLabel setTextColor:[self colorWithHexString:BASE_GREEN_COLOR]];
        [rightBtn setTitleColor:[self colorWithHexString:BASE_GREEN_COLOR] forState:UIControlStateNormal];
        [rightBtn addTarget:sel action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:rightBtn];
        [rightBtn setTag:9002];
    }

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height-1, titleView.frame.size.width, 1)];
    v.backgroundColor = [self colorWithHexString:BASE_GRAY_COLOR];
    [titleView addSubview:v];
    
    
    return titleView;
}

+ (CGFloat)caculateTextLengt:(NSString *)text FontSize:(CGFloat)fontsize withWidth:(CGFloat)width WithHight:(CGFloat)hight{
    
    UIFont *font = [UIFont systemFontOfSize:fontsize];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, hight) lineBreakMode:NSLineBreakByWordWrapping];
    return size.width;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

+ (NSString *)stringFromTimeMillis:(NSTimeInterval)time {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000.0];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
//    return [TimeUtil stringByFormatTimeString:destDateString];
}



+ (NSString *)stringFromDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}

+ (UIButton *)navBackButtonItemWithTitle:(NSString *)title {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 80.0f, 30.0f);
    [backButton setImage:[UIImage imageNamed:@"left_back_arr.png"]  forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [backButton setTitle:title forState:UIControlStateNormal];
    return backButton;
}

+ (NSString *)formattedFileSize:(unsigned long long)size {
    NSString *formattedStr = nil;
    if (size == 0)
		formattedStr = @"0B";
	else
		if (size > 0 && size < 1024)
			formattedStr = [NSString stringWithFormat:@"%quB", size];
        else
            if (size >= 1024 && size < pow(1024, 2))
                formattedStr = [NSString stringWithFormat:@"%.1fKB", (size / 1024.)];
            else
                if (size >= pow(1024, 2) && size < pow(1024, 3))
                    formattedStr = [NSString stringWithFormat:@"%.1fMB", (size / pow(1024, 2))];
                else
                    if (size >= pow(1024, 3))
                        formattedStr = [NSString stringWithFormat:@"%.1fGB", (size / pow(1024, 3))];
	
	return formattedStr;
}

+ (BOOL)isParentsVersion {
    NSString *appId = [self bundleIdentifier];
    if ([appId isEqualToString:@"com.isoftston.Chunlei"] ||
        [appId isEqualToString:@"com.chunlei8.xx.parents"]) {// ||[appId isEqualToString:@"com.isoftstone.MIS"]
        return YES;
    }
    return NO;
}

+ (NSString *)substringInMaxLength:(NSString *)text maxLength:(NSInteger)maxLength{
    NSUInteger asciiLength = 0;
    NSInteger idx = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        if (asciiLength >= maxLength) {
            idx = i;
            if (asciiLength == maxLength) {
                idx = i + 1;
            }
            break;
        }
    }
    return [text substringToIndex:idx];
}

#pragma mark- 检测字符长度

+ (NSUInteger) unicodeLengthOfString: (NSString *) text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

+ (BOOL)isNumberText:(NSString *)string {
    NSString * regex        = @"^[0-9]";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:string];
    return isMatch;
}

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validateFax:(NSString *)fax {
    NSString * faxRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    //@"/^((0\\d{2,3}-)?\\d{7,8})$/";
    //@"/^[+]{0,1}(\\d){1,3}[ ]?([-]?((\\d)|[ ]){1,12})+$/";
    NSPredicate * faxPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",faxRegex];
    return [faxPredicate evaluateWithObject:fax];
}

+ (BOOL)validateNoCharacterChar:(NSString *)string {
    NSString * regex = @"^[A-Za-z0-9\u4e00-\u9fa5_-]+$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)validateNumberOrFloatText:(NSString *)string {
//    NSString * regex = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    NSString * regex = @"^[0-9]+[.]{0,1}[0-9]{0,}$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

/**
 *  归档
 *
 *  @param obj  要归档的对象
 *  @param name 文件名
 */
+ (BOOL)archiveObject:(id)obj toName:(NSString *)name
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *directryPath = [docPath stringByAppendingPathComponent:@"Archiver"];
    NSString *path = [directryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", name]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        
        [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return [NSKeyedArchiver archiveRootObject:obj toFile:path];
}

/**
 *  解归档
 *
 *  @param name 文件名
 */
+ (id)unArchiveFromName:(NSString *)name {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *directryPath = [docPath stringByAppendingPathComponent:@"Archiver"];
    NSString *path = [directryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", name]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


@end
