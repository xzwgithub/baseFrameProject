//
//  ColorDefinition.h
//
//
//  Created by Wonder Chang on 12/6/6.
//  Copyright (c) 2015年 ZL. All rights reserved.
//

#ifndef UA_ViewParameterDefinition_h
#define UA_ViewParameterDefinition_h

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//弹窗背景颜色
#define POPCL_BACK [[UIColor blackColor]colorWithAlphaComponent:.8f]

//主题颜色
#define ZDCL_THEME UIColorFromRGB(0X61acf9) //主题蓝
//主背景色
#define ZDCL_THEME_BK UIColorFromRGB(0Xececec) //背景浅灰色
//主字体颜色
#define ZDCL_THEME_FT UIColorFromRGB(0X858585) //首页浅灰字体
#define ZDCL_THEME_FTS UIColorFromRGB(0X666666) //首页深灰字体
#define ZDCL_THEME_FTR UIColorFromRGB(0Xf36e5d) //金钱文字红色

//主线条颜色
#define ZDCL_THME_LIN ZDCL_THEME_BK //背景灰
#define ZDCL_THME_LIN_SUB UIColorFromRGB(0Xe7e7e7)
#define ZDCL_THEME_FT_SUB UIColorFromRGB(0Xa0a0a0)
#define ZDCL_THEME_SUB UIColorFromRGB(0Xff8d1c)

//操作按钮背景颜色
#define ZDCL_BTNBK_BLU UIColorFromRGB(0X61acf9)//按钮背景蓝色
#define ZDCL_BTNBK_RED UIColorFromRGB(0Xf36e5d)//按钮背景红色
#define ZDCL_BTNBK_GRE UIColorFromRGB(0X999999)//按钮背景灰色

//导航栏背景颜色
#define ZDCL_NAV_BK ZDCL_THEME //主题蓝
//导航栏标题颜色
#define ZDCL_NAV_TITLE UIColorFromRGB(0xFFFFFF)//白色
//导航栏左右item颜色
#define ZDCL_NAV_ITEM UIColorFromRGB(0xFFFFFF)//白色
//tabBar标题默认颜色
#define ZDCL_TABBAR_NOMOL_TITLE  ZDCL_THEME_FT //主字体灰
//tabBar标题选中颜色
#define ZDCL_TABBAR_SELECT_TITLE  ZDCL_THEME //主题蓝
//整体View背景颜色
#define ZDCL_NOMOL_BK ZDCL_THEME_BK //主背景灰


//----------------------字体大小类---------------------------
//导航栏标题字体大小
#define ZDFT_NAV_TITLE 20
//tabBar标题字体大小
#define ZDFT_TABBAR_TITLE 12
//cell字体大小
#define ZDFT_BigFont 17
#define ZDFT_NormalFont 15
#define ZDFT_SmallFont 13
#define ZDFT_SuperSmallFont 10


//----------------------通知KEY类---------------------------
#define NOTICE_NAME_LOGOUT @"notice_name_logout"//注销通知
#define NOTICE_NAME_BACKHOME @"notice_name_backhome"//回到登录界面

#endif
