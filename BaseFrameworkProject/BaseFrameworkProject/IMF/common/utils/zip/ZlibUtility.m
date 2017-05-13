//
//  ZlibUtility.m
//
//  Created by 张 黎 on 12-04-19.
//  Copyright (c) 2012年 张 黎. All rights reserved.
//

#import "ZlibUtility.h"
#import "zlib.h"

@implementation ZlibUtility

//压缩
+ (id) compressDataWithBytes: (const void*) bytes length: (unsigned) length
{
    unsigned long compressedLength = compressBound(length);
    unsigned char* compressedBytes = (unsigned char*) malloc(compressedLength);
    
    if (compressedBytes != NULL && compress(compressedBytes, &compressedLength, bytes, length) == Z_OK) {
        char* resizedCompressedBytes = realloc(compressedBytes, compressedLength);
        if (resizedCompressedBytes != NULL) {
            return [NSData dataWithBytesNoCopy: resizedCompressedBytes length: compressedLength freeWhenDone: YES];
        } else {
            return [NSData dataWithBytesNoCopy: compressedBytes length: compressedLength freeWhenDone: YES];
        }
    } else {
        free(compressedBytes);
        return nil;
    }
}

+ (NSData*)compressData:(NSData *)uncompressedData  {
    return [self compressDataWithBytes: [uncompressedData bytes] length: [uncompressedData length]];
}

//解压缩
+ (NSData *)decompressData:(NSData *)compressedData {
    
    z_stream zStream;
    
    zStream.zalloc = Z_NULL;
    
    zStream.zfree = Z_NULL;
    
    zStream.opaque = Z_NULL;
    
    zStream.avail_in = 0;
    
    zStream.next_in = 0;
    
    int status = inflateInit2(&zStream, (15+32));
    
    
    
    if (status != Z_OK) {
        
        return nil;
        
    }
    
    
    
    Bytef *bytes = (Bytef *)[compressedData bytes];
    
    NSUInteger length = [compressedData length];
    
    
    
    NSUInteger halfLength = length/2;
    
    NSMutableData *uncompressedData = [NSMutableData dataWithLength:length+halfLength];
    
    
    
    zStream.next_in = bytes;
    
    zStream.avail_in = (unsigned int)length;
    
    zStream.avail_out = 0;
    
    //按字节
    NSInteger bytesProcessedAlready = zStream.total_out;
    
    while (zStream.avail_in != 0) {
        
        
        
        if (zStream.total_out - bytesProcessedAlready >= [uncompressedData length]) {
            
            [uncompressedData increaseLengthBy:halfLength];
            
        }
        
        
        
        zStream.next_out = (Bytef*)[uncompressedData mutableBytes] + zStream.total_out-bytesProcessedAlready;
        
        zStream.avail_out = (unsigned int)([uncompressedData length] - (zStream.total_out-bytesProcessedAlready));
        
        
        
        status = inflate(&zStream, Z_NO_FLUSH);
        
        
        
        if (status == Z_STREAM_END) {
            
            break;
            
        } else if (status != Z_OK) {
            
            return nil;
            
        }
        
    }
    
    
    
    status = inflateEnd(&zStream);
    
    if (status != Z_OK) {
        
        return nil;
        
    }
    
    //真实长度
    [uncompressedData setLength: zStream.total_out-bytesProcessedAlready];  // Set real length
    
    
    return uncompressedData;    
    
}


@end
