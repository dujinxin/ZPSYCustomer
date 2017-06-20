//
//  AppDelegate+ADD.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
//#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "notificationModel.h"

@interface AppDelegate (ADD)<JPUSHRegisterDelegate>


- (BOOL)ADDapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)ADDapplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)ADDapplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)ADDapplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (BOOL)ADDapplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
- (BOOL)ADDapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)ADDapplication:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (void)ADDapplicationWillResignActive:(UIApplication *)application;
- (void)ADDapplicationDidEnterBackground:(UIApplication *)application;
- (void)ADDapplicationWillEnterForeground:(UIApplication *)application;
- (void)ADDapplicationDidBecomeActive:(UIApplication *)application;
- (void)ADDapplicationWillTerminate:(UIApplication *)application;
@end
