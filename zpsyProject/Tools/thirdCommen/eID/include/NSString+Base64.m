//
//  NSString+Base64.m
//  eID-SDK
//
//  Created by Jusive on 16/5/23.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import "NSString+Base64.h"
@implementation NSString (Base64)
static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
-(NSString *) base64StringFromData: (NSData *)data {
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    int length = (int)[data length];
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = (const unsigned char *)[data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}
@end
