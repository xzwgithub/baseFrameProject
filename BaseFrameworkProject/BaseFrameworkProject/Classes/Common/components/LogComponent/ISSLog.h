//
//  ISSLog.h
//
//  Created by zhangli on 12-11-27.
//
//

#import "LogUtil.h"

#ifdef DEBUG 
#define NSLog(fmt, ...) NSLog((@"function:%s line:%d content:" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define ISSLog(fmt, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String])
#else

#define ISSLog(fmt, ...)  do {   \
NSString *logFilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/log/%@.log",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"]];  \
if ([[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {    \
NSLog((@"function:%s line:%d content:" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__); \
}   \
} while(0)

#endif