//
//  AppDelegate.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "AppDelegate.h"
#import "ZPSYTabbarVc.h"
#import "AppDelegate+ADD.h"

@interface AppDelegate ()

@property(strong, nonatomic)NSTimer* mTimer;
@property(assign, nonatomic)UIBackgroundTaskIdentifier backIden;

@end

@implementation AppDelegate{
    NSInteger count;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = JXMainColor;
    self.window.rootViewController = [ZPSYTabbarVc new];
    
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    count = 0;
    
    [self ADDapplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [self ADDapplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [self ADDapplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [self ADDapplication:application didReceiveRemoteNotification:userInfo];
}

//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [self ADDapplication:app openURL:url options:options];
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self ADDapplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self ADDapplication:application handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [self ADDapplicationWillResignActive:application];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self ADDapplicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    _mTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_mTimer forMode:NSRunLoopCommonModes];
    [self beginTask];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self ADDapplicationWillEnterForeground:application];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self endBack];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self ADDapplicationDidBecomeActive:application];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}
//计时
-(void)countAction{
    //NSLog(@"%ld",(long)count++);
}
//申请后台
-(void)beginTask
{
    NSLog(@"begin=============");
    _backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        //在时间到之前会进入这个block，一般是iOS7及以上是3分钟。按照规范，在这里要手动结束后台，你不写也是会结束的（据说会crash）
        NSLog(@"将要挂起=============");
        [self endBack];
    }];
}
//注销后台
-(void)endBack
{
    NSLog(@"end=============");
    [[UIApplication sharedApplication] endBackgroundTask:_backIden];
    _backIden = UIBackgroundTaskInvalid;
    [_mTimer invalidate];
    _mTimer = nil;
}

@end

