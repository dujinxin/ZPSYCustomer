//
//  CDNetworkReachabilityManager.h
//  OCLog
//
//  Created by LCD on 16/2/25.
//  Copyright © 2016年 LCD. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, CDNetworkReachabilityStatus) {
    CDNetworkReachabilityStatusUnknown          = -1,
    CDNetworkReachabilityStatusNotReachable     = 0,
    CDNetworkReachabilityStatusReachableViaWWAN = 1,
    CDNetworkReachabilityStatusReachableViaWiFi = 2,
};

typedef void(^CDNetworkReachabilityStatusBlock)(CDNetworkReachabilityStatus);


NS_ASSUME_NONNULL_BEGIN
@interface CDNetworkReachabilityManager : NSObject
/**
 *  网络的状态
 */
@property (nonatomic,assign,readonly) CDNetworkReachabilityStatus networkReachabilityStatus;

@property (nonatomic,assign,readonly,getter = isWifi ) BOOL Wifi;
@property (nonatomic,assign,readonly,getter = isWWAN) BOOL WWAN;
@property (nonatomic,assign,readonly,getter=isReachable) BOOL Reachable;

+ (instancetype)sharedManager;
/**
 *  开始监控网络
 */
- (void)startMonitoring;
/**
 *  结束监控网络
 */
- (void)stopMonitoring;
/**
 *  设置网络改变时调用的block
 *
 *  @param block
 */
- (void)setNetworkReachabilityStatusBlock:(nullable void (^)(CDNetworkReachabilityStatus status))block;

@end


NS_ASSUME_NONNULL_END
#endif

