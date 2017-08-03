//
//  NSData+Hex.m
//  DongxinSimDemo
//
//  Created by chopper on 16/3/3.
//  Copyright © 2016年 trimps. All rights reserved.
//

#import "NSData+Hex.h"

@implementation NSData (Hex)
- (NSString *)hexFromData{
    NSInteger len = self.length;
    char *hexBuffer = malloc(sizeof(char)*(len*2 + 1));
    const char *bytes = self.bytes;
    const char *hexChars = "0123456789ABCDEF";
    char *p = hexBuffer;
    for (int i = 0; i < len; i++) {
        *p++ = hexChars[(bytes[i]>>4) & 0x0F];
        *p++ = hexChars[bytes[i] & 0x0F];
    }
    *p = '\0';

    NSString *str = [[NSString stringWithUTF8String:hexBuffer]uppercaseString];
    free(hexBuffer);
    return str;
}
@end
