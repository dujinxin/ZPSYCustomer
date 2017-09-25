//
//  ScanningShootVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ScanningShootVC.h"
#import "Scanview.h"
#import "WKwebVC.h"
#import "ZPSYNav.h"
#import "JXViewManager.h"
#import "ZPSY-Swift.h"

#import "ScanDetailViewController.h"
@interface ScanningShootVC ()<UIAlertViewDelegate>{

}
@property(nonatomic,strong)Scanview *scanview;

@end

@implementation ScanningShootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewinit];
    
    //[[GDLocationManager manager] startLocation];
    //[[GDLocationManager manager] startUpdateLocation];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    self.scanview.StartScaning = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.scanview.StartScaning =  NO;
}

-(void)scanresultWithValue:(NSString *)codeValue Type:(ScanTypeEnum) type{
    
    self.scanview.StartScaning = NO;
    
    if ([GDLocationManager manager].isEnabled == YES ){
        if ([GDLocationManager manager].location == nil || [GDLocationManager manager].reGeocode == nil || [GDLocationManager manager].isLoacating == YES) {
            
            //[[JXViewManager sharedInstance] showJXNoticeMessage:@"正在定位，请稍候再试"];
            self.scanview.StartScaning = YES;
        
            return;
        }
    }else{
        LocationViewController * alert = [[LocationViewController alloc ] init ];
        [self.navigationController pushViewController:alert animated:NO];
        return;
    }
    
    if (type==ScanTypeQRCode || type==ScanTypeBarCode || type==ScanTypeGmCode || type==ScanTypeOther) {
        
        if (codeValue==nil || [codeValue isEqualToString:@""]) {
            [self AlertShowWithStr:@"解码失败"];
        }else{
            [self snRequestWithCode:codeValue];
        }
    }else{
        [self AlertShowWithStr:@"解码失败"];
    }
    
}

-(void)snRequestWithCode:(NSString*)codeStr{
    

    NSDictionary *dict = @{@"codeId":codeStr,
                           @"scanMobile":[UserManager manager].userEntity.mobile,
                           @"country":[GDLocationManager manager].reGeocode.country,
                           @"province":[GDLocationManager manager].reGeocode.province,
                           @"city":[GDLocationManager manager].reGeocode.city,
                           @"district":[GDLocationManager manager].reGeocode.district,
                           @"street":[GDLocationManager manager].reGeocode.street,
                           @"number":[GDLocationManager manager].reGeocode.number,
                           @"address":[GDLocationManager manager].reGeocode.formattedAddress,
                           
//                           @"longitude":self.LocManager.longitute,
//                           @"latitude":self.LocManager.latitude,
                           @"longitude":[NSString stringWithFormat:@"%f",[GDLocationManager manager].location.coordinate.longitude],
                           @"latitude":[NSString stringWithFormat:@"%f",[GDLocationManager manager].location.coordinate.latitude],
                           @"model":[Utility getCurrentDeviceModel]
                           };
    [BaseSeverHttp ZpsyPostWithPath:Api_scanRecordFind WithParams:dict WithSuccessBlock:^(NSDictionary* result) {
        
        if ([[result objectForKey:@"goodsStatus"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict = [result objectForKey:@"goodsStatus"];
            if ([[dict objectForKey:@"status"] integerValue] != 1) {
                UIAlertView * alert = [[UIAlertView alloc ] initWithTitle:nil message:dict[@"describe"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                return;
            }
        }
        scanFinishModel *model = [[scanFinishModel alloc] init];
        [model setmodelWithScandict:result];
        
        if ([model.quality isEqualToString: @"-1"]) {
            [self failShowVC];
            return;
        }
        
        ScanDetailViewController *vc= [[ScanDetailViewController alloc] init];
        //vc.view.backgroundColor = JXFfffffColor;
        vc.hidesBottomBarWhenPushed = YES;
        vc.scanFinishModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
}


//失败页面
-(void)failShowVC{
    WKwebVC *web = [[WKwebVC alloc] init];
    web.IsrequestFile = YES;
    web.pathStr = @"scannoresult.html";
    [self.navigationController pushViewController:web animated:YES];
};


/**
 失败提示
 @param str 提示语
 */
-(void)AlertShowWithStr:(NSString*)str{
    @weakify(self);
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        self.scanview.StartScaning=YES;
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)viewinit{
    [self.view insertSubview:self.scanview atIndex:0];
    [self backButSet];
    [self FlickerButSet];
    [self otherViewInit];
}

-(Scanview *)scanview{
    
    if (!_scanview) {
        _scanview=[[Scanview alloc] initWithFrame:kScreenBounds];
        @weakify(self);
        [_scanview setScanResultBlock:^(NSString *codeValue, ScanTypeEnum type) {
            @strongify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self scanresultWithValue:codeValue Type:type];
            });
        }];
    }
    return _scanview;
}

-(void)otherViewInit{

    UIView *navStatusView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    navStatusView.backgroundColor = JXMainColor;
    [self.view addSubview:navStatusView];

    UILabel *zpsyLab=[[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenHeight+kWidth_fit(250))/2.0, kScreenWidth, 20)];
    zpsyLab.text=@"扫正品溯源码,验产品真伪";
    zpsyLab.font=[UIFont systemFontOfSize:15];
    zpsyLab.textAlignment=NSTextAlignmentCenter;
    zpsyLab.textColor=[UIColor whiteColor];
    [self.view addSubview:zpsyLab];
}

-(void)FlickerButSet{
    
    CGFloat wid=35;
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-wid-20, 40, wid, wid)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"flickeroff"] forState:UIControlStateNormal];
    btn.tag=1;
    btn.layer.cornerRadius=wid/2;
    [self.view addSubview:btn];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *bt) {
        @strongify(self);
        if (bt.tag==1) {
            [btn setBackgroundImage:[UIImage imageNamed:@"flickeron"] forState:UIControlStateNormal];
            bt.tag=2;
            self.scanview.OpenStrobeLight=YES;
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"flickeroff"] forState:UIControlStateNormal];
            bt.tag=1;
            self.scanview.OpenStrobeLight=NO;
        }
    }];
}

-(void)backButSet{
    
    CGFloat wid=35;
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(20, 40, wid, wid)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.8];
    btn.layer.cornerRadius=wid/2;
    btn.layer.zPosition=999;
    [btn addTarget:self action:@selector(backBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)backBtnClickEvent{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.scanview.StartScaning = YES;
}

@end
