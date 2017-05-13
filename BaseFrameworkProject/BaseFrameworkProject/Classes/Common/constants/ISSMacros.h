//
//  ISSMacros.h
//
//  Created by Wonder Chang on 13/4/6.
//  Copyright (c) 2013年 ZL. All rights reserved.
//

#import "AppConstants.h"
#import "LanguageRes.h"
#import "ViewParameterDefinition.h"

#ifndef ISSMacros_h
#define ISSMacros_h

//-------------------获取设备大小-------------------------
#define kStatusBarHeight 20.0f
//NavBar高度
#define NavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT (SCREEN_BOUNDS.size.height)

//-------------------获取设备大小-------------------------

//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(name) [UIImage imageNamed:name]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------


//----------------------系统----------------------------

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/****************************************屏幕尺寸*******************************************/
#define iPhone_40inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone_47inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone_35inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone_55inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//判断是否大于 IOS7
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//判断是否大于 IOS8
#define IS_IOS8 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

//判断是否大于 IOS9
#define IS_IOS9 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")


//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)
//快速将一个对象字符串话
#define HY_objToString(obj) [NSString stringWithFormat:@"%@",obj]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)


//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

//全局的Window
#define KEYWINDOW [UIApplication sharedApplication].keyWindow

//xib cell
#define NIBCELL(cellID) [tableView dequeueReusableCellWithIdentifier:cellID]; if(!cell){ cell = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject; }
#define NibCell_WithName(cellID,cellName) [tableView dequeueReusableCellWithIdentifier:cellID]; if(!cellName){ cellName = [[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil].lastObject; }
//xib view
#define NIBVIEW(viewClass) [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([viewClass class]) owner:self options:nil].lastObject
//读plis 数组
#define PLIS_GET_ARR(nameStr) [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:nameStr ofType:@"plist"]]
//读plis 字典
#define PLIS_GET_DIC(nameStr) [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:nameStr ofType:@"plist"]]
//判定nil,不为nil返回本身，为nil则返回空字符串
#define ISNIL(obj)  !obj?@"":obj
//self 的弱引用
#define  WeakSelf(weakSelf)  __weak typeof(self) weakSelf =  self;

#endif
