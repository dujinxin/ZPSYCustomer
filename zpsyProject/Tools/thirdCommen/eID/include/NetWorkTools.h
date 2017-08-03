//
//  NetWorkTools.h
//  通用框架
//
//  Created by Jusive on 16/1/27.
//  Copyright © 2016年 Jusive. All rights reserved.
//
//用网络工具类隔离变化
//#import "AFNetworking/AFNetworking.h"
#import "AFNetworking.h"
#import <Foundation/Foundation.h>

@interface NetWorkTools : AFHTTPSessionManager
+(AFHTTPSessionManager *)sharedNetWorkTool;
+(NSString *)str:(NSString *)urlstr;
@end
