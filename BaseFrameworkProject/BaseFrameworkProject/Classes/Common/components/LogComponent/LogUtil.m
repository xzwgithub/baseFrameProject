//
//  LogUtil.m
//
//  Created by issuser on 12-11-27.
//
//

#import "LogUtil.h"
#import "ISSLog.h"

@implementation LogUtil

+ (void)writeLogToFile {
    if (![[[UIDevice currentDevice] name] hasSuffix:@"Simulator"]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fileName =[NSString stringWithFormat:@"%@.log",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"]];
        NSString *logDir = [documentsDirectory stringByAppendingPathComponent:@"log"];
        NSString *logFilePath = [logDir stringByAppendingPathComponent:fileName];
//        if ([[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
//            freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
//        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
            //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
            BOOL ret =  [[NSFileManager defaultManager] createDirectoryAtPath:logDir withIntermediateDirectories:YES attributes:nil error:nil];
            NSAssert(ret,@"创建目录失败");
            
            ret = [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
            
            NSAssert(ret,@"创建日志文件失败");
        }
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
    }
}

+ (void)handleCrashException {
	NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

void UncaughtExceptionHandler(NSException *exception) {
	NSArray *arr = [exception callStackSymbols];
	NSString *reason = [exception reason];
	NSString *name = [exception name];
    
    NSString *errorString = [NSString stringWithFormat:@"[Exception name]:%@\n[Exception reason]:%@\n[Exception callStackSymbols]:%@",name,reason,[arr componentsJoinedByString:@"\n"]];
    
	//错误异常报告写文件
    NSData *data = [errorString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"log"];

    NSString *writePath = [logPath stringByAppendingPathComponent:[LogConfig logFileName]];
    BOOL isFolder = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:logPath isDirectory:&isFolder]) {
        //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
        [[NSFileManager defaultManager] createDirectoryAtPath:logPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    else {
        NSArray *logFileArray = [[[NSFileManager defaultManager]
                                  contentsOfDirectoryAtPath:logPath error:nil]
                                 pathsMatchingExtensions:@[@"txt"]];
        NSLog(@"logFileArray:%@",logFileArray);
        if ([logFileArray count]>=LogConfig.logFileMaxNum) {
            NSLog(@"超过配置的错误日志数，需删除：%@", [logFileArray objectAtIndex:0]);
            NSString *deleteLogPath = [documentsDirectory stringByAppendingFormat:@"/log/%@", [logFileArray objectAtIndex:0]];
            NSError *error = nil;
            if ([[NSFileManager defaultManager] removeItemAtPath:deleteLogPath error:&error]) {
                NSLog(@"delete error report success!");
            }
            else {
                NSLog(@"delete error report fail:%@",[error userInfo]);
            }
        }
    }
    [data writeToFile:writePath atomically:YES];
    
}

+ (BOOL)hasCrashReport {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"log"];
    
    NSArray *logFileArray = [[[NSFileManager defaultManager]
                               contentsOfDirectoryAtPath:logPath error:nil]
                             pathsMatchingExtensions:@[@"txt"]];
    NSLog(@"logFileArray:%@",logFileArray);
    
    return [logFileArray count]>0;
}

- (void)deleteCrashReport {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"log"];
    NSArray *logFileArray = [[[NSFileManager defaultManager]
                              contentsOfDirectoryAtPath:logPath error:nil]
                             pathsMatchingExtensions:@[@"txt"]];
    for (NSString *fileName in logFileArray) {
        NSString *writePath = [documentsDirectory stringByAppendingFormat:@"/log/%@", fileName];
        NSError *error = nil;
        if ([[NSFileManager defaultManager] removeItemAtPath:writePath error:&error]) {
            NSLog(@"delete error report success!");
        }
        else {
            NSLog(@"delete error report fail:%@",[error userInfo]);
        }
    }
    
}

- (NSString *)getCrashContentByName:(NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writePath = [documentsDirectory stringByAppendingFormat:@"/log/%@", fileName];
    
    NSError *error;
    
    NSString *textFileContents = [NSString stringWithContentsOfFile:writePath
                                                           encoding:NSUTF8StringEncoding
                                                              error:&error];
    
    // If there are no results, something went wrong
    
    if (textFileContents == nil) {
        
        // an error occurred
        
        NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
        
    }
    
    //    NSArray *lines = [textFileContents componentsSeparatedByString:@""];
    //
    //    NSLog(@"Number of lines in the file:%d", [lines count] );
    return textFileContents;
}

- (long long)getLogOccurrenceTimeByLogName:(NSString *)fileName {
    NSString *dateFormat = @"yyyy-MM-dd_HH-mm-ss-SSS";

    NSRange range = NSMakeRange([CRASHLOG_FILE_PREFIX length]+1, [dateFormat length]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *logTime = [fileName substringWithRange:range];
    
    ISSLog(@"日志发生时间：%@", logTime);

    NSDate *date = [dateFormatter dateFromString:logTime];
    
    return [date timeIntervalSince1970]*1000;

}


/**
 给提示用户上传错误日志，用户点击确定后上传，如果点击取消将清除全部错误日志
 @param nil
 @return nil
 */

- (void)showTipBeforeUploadLog {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kErr_Report_Title
                                                    message:kErr_Report_Message
                                                   delegate:self
                                          cancelButtonTitle:kErr_Report_Btn_Cancel
                                          otherButtonTitles:kErr_Report_Btn_Sure,nil];
    [alert show];
//    [alert release];
}

/**
 上传错误日志。此方法适用于无需弹框提醒用户的情况下上传错误日志
 @param nil
 @return nil
 */
- (void)uploadLog {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"log"];
    NSArray *logFileArray = [[[NSFileManager defaultManager]
                              contentsOfDirectoryAtPath:logPath error:nil]
                             pathsMatchingExtensions:@[@"txt"]];
    
    //组装 json
    NSMutableArray *dataList = [NSMutableArray array];
    for (NSString *fileName in logFileArray) {
        CrashLog *entity = [[CrashLog alloc] init];
        entity.when = [self getLogOccurrenceTimeByLogName:fileName];
        entity.content = [self getCrashContentByName:fileName];
        entity.type = 1;
        
        [dataList addObject:[entity toDictionary]];
    }
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:URL_CRASHLOG_REPORT]];
    
    [request setHTTPMethod:@"POST"];
    
    [request addValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"text/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    NSDictionary *bodyDict = @{@"dataList": dataList};
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:bodyDict options:NSJSONWritingPrettyPrinted error:nil];
    
    [postBody appendData:body];
    
    [request setHTTPBody:postBody];
    

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:config
                                                           delegate:nil
                                                      delegateQueue:queue];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                if (responseDictionary && [[responseDictionary objectForKey:@"rcode"] intValue] == 0) {
                                                    ISSLog(@"上传错误日志成功！");
                                                    //删除错误日志
                                                    [self deleteCrashReport];
                                                }
                                                else {
                                                    ISSLog(@"上传错误日志失败！");
                                                }
                                                
                                            }];
    [task resume];
}



#pragma mark -
#pragma mark UIAlertViewDelegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //不上报，并且删除文件
        ISSLog(@"buttonIndex:%ld",(long)buttonIndex);
        [self deleteCrashReport];
        
//        if (self) {
//            [self release];
//        }
    }
    else {
        //上报错误日志，上传成功后才删除
        [self uploadLog];
    }
}

@end
