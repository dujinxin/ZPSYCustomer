//
//  NSString+Hex.m
//  DongxinSimDemo
//
//  Created by chopper on 16/3/3.
//  Copyright © 2016年 trimps. All rights reserved.
//

#import "NSString+Hex.h"

@implementation NSString (Hex)
- (NSData *)dataFromHexString{
    NSString *tmp = [[self uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger len = tmp.length;
    if (len%2 != 0) {
        return nil;
    }
    for (int i=0; i<len; i++) {
        unichar c = [tmp characterAtIndex:i];
        if ((c >= '0' && c <= '9') || ( c >= 'A' && c <= 'F')) {
            continue;
        }else{
            return nil;
        }
    }
    char bytes[3]= {'\0', '\0', '\0'};
    const char *chars = [tmp UTF8String];
    NSInteger i = 0;
    NSMutableData *data = [NSMutableData dataWithCapacity:len];
    unsigned long byteValue;
    while (i<len) {
        bytes[0] = chars[i++];
        bytes[1] = chars[i++];
        byteValue = strtoul(bytes, NULL, 16);
        [data appendBytes:&byteValue length:1];
    }
    return data;
}

@end
