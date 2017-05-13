//
//  ISSARC.h
//  UA
//
//  Created by issuser on 14-6-5.
//  Copyright (c) 2014年 issuser. All rights reserved.
//

#ifndef UA_ISSARC_h
#define UA_ISSARC_h

#ifndef ISS_STRONG
#if __has_feature(objc_arc)
#define ISS_STRONG strong
#else
#define ISS_STRONG retain
#endif
#endif

#ifndef ISS_WEAK
#if __has_feature(objc_arc_weak)
#define ISS_WEAK weak
#elif __has_feature(objc_arc)
#define ISS_WEAK unsafe_unretained
#else
#define ISS_WEAK assign
#endif
#endif

#if __has_feature(objc_arc)
#define ISS_AUTORELEASE(exp) (exp)
#define ISS_RELEASE(exp) (exp)
#define ISS_RETAIN(exp) (exp)
#else
#define ISS_AUTORELEASE(exp) ([exp autorelease])
#define ISS_RELEASE(exp) ([exp release])
#define ISS_RETAIN(exp) ([exp retain])
#endif

/***在ARC项目中使用 performSelector: withObject: 函数出现
 “performSelector may cause a leak because its selector is unknown”。
 
 如果没有返回结果，可以直接按如下方式调用：
 SuppressPerformSelectorLeakWarning(
 [_target performSelector:_action withObject:self]
 );
 如果要返回结果，可以按如下方式调用:
 id result;
 SuppressPerformSelectorLeakWarning(
 result = [_target performSelector:_action withObject:self]
 );
 
 */

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif
