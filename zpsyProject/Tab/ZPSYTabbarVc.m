//
//  ZPSYTabbarVc.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ZPSYTabbarVc.h"
#import "ZPSYNav.h"
#import "HomeVC.h"
#import "HistoryVC.h"
#import "ScanningShootVC.h"
#import "ExposureVC.h"
#import "MineVC.h"
#import "ZPSY-Swift.h"

#define photoIdentifier @"photoIdentifierJadge"
@interface ZPSYTabbarVc ()<UITabBarControllerDelegate>
@property(nonatomic,strong)ZPSYNav *scaningNav;
@end

@implementation ZPSYTabbarVc
- (void)viewDidLoad {
    [super viewDidLoad];
    [self launchuserScore];
    // Do any additional setup after loading the view.
    self.delegate=self;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];  //此处UIImage可以使用对应颜色的背景图即可
    
    ZPSYNav *homeNav=[[ZPSYNav alloc] initWithRootViewController:[HomeVC new]];
    ZPSYNav *historyNav=[[ZPSYNav alloc] initWithRootViewController:[HistoryVC new]];
    ZPSYNav *exposureNav=[[ZPSYNav alloc] initWithRootViewController:[ExposureVC new]];
    ZPSYNav *mineVcNav=[[ZPSYNav alloc] initWithRootViewController:[MineVC new]];
    UIViewController *scaningShoot=[UINavigationController new];
    scaningShoot.restorationIdentifier=photoIdentifier;
    
    self.viewControllers=@[homeNav,historyNav,scaningShoot,exposureNav,mineVcNav];
    
    NSArray *arr=@[@{@"title":homeTile,@"image":@"tab_home_selected",@"unimage":@"tab_home_normal"},
               @{@"title":histotyTile,@"image":@"tab_history_selected",@"unimage":@"tab_history_normal"},
               @{@"title":@"",@"image":@"tab_camera"},
               @{@"title":exposureTile,@"image":@"tab_find_selected",@"unimage":@"tab_find_normal"},
               @{@"title":mineTile,@"image":@"tab_my_selected",@"unimage":@"tab_my_normal"}
            ];
    [arr enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.viewControllers[idx].tabBarItem.title = obj[@"title"];
        if (idx==2) {
            self.viewControllers[idx].tabBarItem.image=[[UIImage imageNamed:obj[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.viewControllers[idx].tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
        }else{
            self.viewControllers[idx].tabBarItem.image=[[UIImage imageNamed:obj[@"unimage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.viewControllers[idx].tabBarItem.selectedImage=[[UIImage imageNamed:obj[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:JX333333Color} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:JXMainColor} forState:UIControlStateSelected];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if (viewController.restorationIdentifier &&[viewController.restorationIdentifier isEqualToString: photoIdentifier]) {
        [self pushToScanVC];
        return NO;
    }
    return YES;
}
-(void)pushToScanVC{
    if (TARGET_IPHONE_SIMULATOR) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"模拟器暂时不支持扫描" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [[GDLocationManager manager] startUpdateLocation];
        ScanningShootVC *scaningshootVc = [ScanningShootVC new];
        ZPSYNav *nav = [[ZPSYNav alloc] initWithRootViewController:scaningshootVc];
        [self presentViewController:nav animated:NO completion:nil];
//        if ([CTUtility handleWithAuthWith:AuthorizationTakePhoto]) {
//            ScanningShootVC *scaningshootVc = [ScanningShootVC new];
//            ZPSYNav *nav=[[ZPSYNav alloc] initWithRootViewController:scaningshootVc];
//            [self presentViewController:nav animated:NO completion:nil];
//        }else{
//            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"设备权限未打开，请在设置->隐私->相机中进行设置！" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController:alert animated:YES completion:nil];
//        }
    }
}


-(void)launchuserScore{
    if ([UserManager manager].isLogin){
        [BaseSeverHttp afnetForZpsyGetWithPath:Api_userScoreChange WithParams:@{@"type":@"1"} WithSuccessBlock:nil WithFailurBlock:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
