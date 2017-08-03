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
    
    NSArray *arr=@[@{@"title":homeTile,@"image":@"tabbar_0",@"unimage":@"tabbar_00"},
               @{@"title":histotyTile,@"image":@"tabbar_1",@"unimage":@"tabbar_11"},
               @{@"title":@"",@"image":@"tabbar_2"},
               @{@"title":exposureTile,@"image":@"tabbar_3",@"unimage":@"tabbar_33"},
               @{@"title":mineTile,@"image":@"tabbar_4",@"unimage":@"tabbar_44"}
            ];
    [arr enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.viewControllers[idx].tabBarItem.title=obj[@"title"];
        if (idx==2) {
            self.viewControllers[idx].tabBarItem.image=[[UIImage imageNamed:obj[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else{
            self.viewControllers[idx].tabBarItem.image=[[UIImage imageNamed:obj[@"unimage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.viewControllers[idx].tabBarItem.selectedImage=[[UIImage imageNamed:obj[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
    }];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.75]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:1]} forState:UIControlStateSelected];
    [self.tabBar setBackgroundColor:kColor_red];
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
        
        if ([CTUtility handleWithAuthWith:AuthorizationTakePhoto]) {
            ScanningShootVC *scaningshootVc=[ScanningShootVC new];
            ZPSYNav *nav=[[ZPSYNav alloc] initWithRootViewController:scaningshootVc];
            [self presentViewController:nav animated:NO completion:nil];
        }
        else{
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"设备权限未打开，请在设置->隐私->相机中进行设置！" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}


-(void)launchuserScore{
    if ([UserModel ShareInstance].IsLogin){
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
