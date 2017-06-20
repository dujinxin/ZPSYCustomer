//
//  AFHTTPClient.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/5.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface AFHTTPClient : AFHTTPSessionManager
+ (instancetype)sharedManager;
@end
