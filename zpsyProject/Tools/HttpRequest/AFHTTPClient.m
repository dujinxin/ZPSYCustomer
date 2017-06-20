//
//  AFHTTPClient.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/5.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "AFHTTPClient.h"
#import "KeyChainMethod.h"
@implementation AFHTTPClient
+ (instancetype)sharedManager {
    static AFHTTPClient *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        
        [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"platform"];
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"client"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@",[Utility getCurrentDeviceModel],[Utility systemVersionString]] forHTTPHeaderField:@"os"];
        [manager.requestSerializer setValue:[Utility getCurrentDeviceModel] forHTTPHeaderField:@"mobileType"];
        [manager.requestSerializer setValue:[CTUtility getAppVersion] forHTTPHeaderField:@"version"];
        [manager.requestSerializer setValue:[KeyChainMethod getUniqueDeviceIdentifierAsString] forHTTPHeaderField:@"uuid"];
        [manager.requestSerializer setValue:[self getUaString] forHTTPHeaderField:@"ua"];
        
    });
    
    [manager.requestSerializer setValue:[UserModel ShareInstance].TOKEN forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[CTUtility GetTimeStamp] forHTTPHeaderField:@"timestamp"];
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        self.securityPolicy.allowInvalidCertificates = NO;
    }
    return self;
}

+(NSString*)getUaString{

    NSString *version = [CTUtility getAppVersion];
    NSString *udid = [KeyChainMethod getUniqueDeviceIdentifierAsString];
    NSString *systemnameversion = [Utility systemVersionString];
    NSString *DevicePlatform = [Utility getCurrentDeviceModel];
    
    NSString * uaStr = [NSString stringWithFormat:@"zpsy@%@_AppStore_%@(%@;%@)",version,udid,systemnameversion,DevicePlatform];
    return uaStr;
}

@end
