//
//  QiniuUploadHelper.m
//  ZPSY
//
//  Created by zhouhao on 2017/3/25.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "QiniuUploadHelper.h"

@implementation QiniuUploadHelper
static id _instance = nil;
+ (id)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedUploadHelper {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}
@end
