//
//  NSString+ContainsString.m
//  IdspSDKSample
//
//  Created by zly on 15/8/17.
//  Copyright (c) 2015年 trimps. All rights reserved.
//

#import "NSString+ContainsString.h"

@implementation NSString (ContainsString)

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

@end
