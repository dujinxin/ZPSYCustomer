//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"
#import "UIView+Extension.h"

//#define width kScreenWidth/6

@implementation MBProgressHUD (Add)

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:nil view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:nil view:view];
}

#pragma mark 加载信息包含文字
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

#pragma mark - 工程常用方法
+ (void)showSuccess:(NSString *)success
{
    [MBProgressHUD hideHUD];
    [self showSuccess:success toView:nil];
}

+ (void)showString:(NSString *)string {
    [MBProgressHUD hideHUD];
     UIView *view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = string;
    
    hud.label.textColor = [UIColor whiteColor];
    
    hud.bezelView.color = [UIColor blackColor];
    
    hud.bezelView.alpha = 1.0;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

}

+ (void)showError:(NSString *)error
{
    [MBProgressHUD hideHUD];
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showAnimation
{
    [MBProgressHUD hideHUD];
    return [self showAnimationtoView:nil];
}

#pragma mark 显示文字信息
+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = text;
    
    hud.label.textColor = [UIColor whiteColor];
    
    hud.bezelView.color = [UIColor blackColor];
    
    hud.bezelView.alpha = 1.0;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
    
    return hud;
}

#pragma mark 显示加载动画
+ (MBProgressHUD *)showAnimationtoView:(UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//
//    hud.mode = MBProgressHUDModeCustomView;
//    
//    //背景方块颜色
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor; //隐藏方框
//    hud.bezelView.color = [UIColor clearColor];
//    
//    //当前hudview
//    hud.customView = [self MBanimationView];
//    
//   
//    
//    //展示文字为空
//    hud.label.text = nil;
//    
//    //隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    
//    //蒙板背景色
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    
//    hud.userInteractionEnabled = YES;
////    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hudClick:)];
////    [hud.backgroundView addGestureRecognizer:tap];
//    hud.backgroundView.color = [UIColor clearColor];
//    
//    //60秒之后再消失
//    [hud hideAnimated:YES afterDelay:60];
//    
    return hud;
}

+ (UIView *)MBanimationView{
    //添加一个正在加载的动画 (这里修改了一个indicator.translatesAutoresizingMaskIntoConstraints = YES)
//    UIImageView *animationView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, width, width)];
//    animationView.animationDuration = 1;
//    animationView.animationRepeatCount = 100;
//    animationView.image = [UIImage imageNamed:@"loading_1"];
//    NSMutableArray *temp = [NSMutableArray array];
//    for (int i = 0; i<10; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i+1]];
//        [temp addObject:image];
//    }
//    animationView.animationImages = temp;
//    
//    [animationView startAnimating];
    
    UIActivityIndicatorView*animationView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(15, 0, 80, 80)];
    [animationView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [animationView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [animationView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    animationView.layer.cornerRadius=8;
    [animationView startAnimating];
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, 95)];
    [view addSubview:animationView];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

+ (void)hudClick:(UIGestureRecognizer *)tap{
    
}

@end
