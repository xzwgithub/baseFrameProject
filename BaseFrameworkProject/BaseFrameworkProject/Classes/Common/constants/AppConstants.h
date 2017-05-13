//
//  AppConstants.h
//  UniversalArchitecture
//
//  Created by zhangli on 12-10-26.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

/**
 *
 * 公共常量类 (需要写清楚注释，以"斜杠+两个星号"开头)
 *
 * @author  zhangli
 * @version  [V1.0.0, 2012-10-26]
 */
/**********************************响应码定义*************************************/
/** 请求成功  */
#define RCODE_SUCCESS               0

/** 请求失败  */
#define RCODE_FAIL                  1

/** Session失效 */
#define RCODE_SESSION_INVALID       10001
/** 重复操作 */
#define RCODE_REDONE                10002
/** 网络器异常  */
#define RCODE_NET_ERROR             20009

/** 请求数据不存在  */
#define RCODE_NO_DATA               30003

/** 解析上传文件失败  */
#define RCODE_FILE_ERROR            30004

/** 上传的数据不合法  */
#define RCODE_UP_DATE_ERROR         30005

/** 服务器异常  */
#define RCODE_SERVE_ERROR           40001

/** 已是最新版本  */
#define RCODE_IS_NEW                50004

/** 请求超时时间 */
#define kRequsetTimeOutSeconds      10.0



/********************************** Constant *************************************/



/****************************************枚举定义*******************************************/








