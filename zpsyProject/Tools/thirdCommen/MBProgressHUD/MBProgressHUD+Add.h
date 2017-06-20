//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
/**
 *  在指定View上显示一条成功信息
 *
 *  @param success 成功提示字符串
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 *  在指定View上显示一条错误信息
 *
 *  @param error 错误提示字符串
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 *  显示一条错误信息，稍后提示框会自动隐藏
 *
 *  @param error 错误提示字符串
 */
+ (void)showError:(NSString *)error;

/**
 *  显示一条成功信息，稍后提示框会自动隐藏
 *
 *  @param success 成功提示字符串
 */
+ (void)showSuccess:(NSString *)success;

/**
 *  显示一信息 需要手动移除
 *
 *  @param string 提示字符串
 */
+ (void)showString:(NSString *)string;

/**
 *  展示加载动画,keywindow作为背景
 */
+ (MBProgressHUD *)showAnimation;

/**
 *  展示加载动画在一个view上
 */
+ (MBProgressHUD *)showAnimationtoView:(UIView *)view;

/**
 *  隐藏提示
 */
+ (void)hideHUD;

/**
 *  隐藏view上的
 */
+ (void)hideHUDForView:(UIView *)view;


@end
