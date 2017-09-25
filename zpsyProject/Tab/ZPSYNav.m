//
//  ZPSYNav.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ZPSYNav.h"

@interface ZPSYNav ()

@end

@implementation ZPSYNav

- (void)viewDidLoad {
    [super viewDidLoad];
    _nav_return = @"nav_return";
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.navigationBar setBarTintColor:JXMainColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.shadowImage=[UIImage imageNamed:@""];
//    self.hidesBarsOnSwipe = YES;
//    self.hidesBarsOnTap = YES;
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        UIImage *backButtonTheme = [UIImage imageNamed:_nav_return];
        backButtonTheme = [backButtonTheme imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *backButtom = [[UIBarButtonItem alloc] initWithImage:backButtonTheme style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = backButtom;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
