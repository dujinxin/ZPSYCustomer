//
//  HomeVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "HomeVC.h"
#import "ZPSY-Swift.h"
#import "UshareGetinfo.h"
#import "UIImageView+LocaSdImageCache.h"
#import <SDCycleScrollView.h>
#import "ZPSYTabbarVc.h"
#import "ExposureDetailVC.h"
#import <AFNetworking.h>
#import "homeModel.h"
#import "ScanningShootVC.h"
#import "ZPSYNav.h"
#import "WKwebVC.h"
#import "homeModel.h"

#import "ScanDetailViewController.h"
@interface HomeVC ()<UITableViewDataSource,UITableViewDelegate>{
}

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)SDCycleScrollView *sdCycleScrollView;
@property(nonatomic,strong)homeModel *homemodel;

@end

@implementation HomeVC
@synthesize homemodel = _homemodel;

-(void)loadView{
    self.view=self.tableview;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.sdCycleScrollView adjustWhenControllerViewWillAppera];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=homeTile;
    [self resetBut];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self datarequest];
    }];
    [self.tableview.mj_header beginRefreshing];
}


-(void)datarequest{

//    [MBProgressHUD showAnimationtoView:self.view];
    [BaseSeverHttp ZpsyGetWithPath:Api_homePage WithParams:nil WithSuccessBlock:^(id result) {
        [self.tableview.mj_header endRefreshing];
//        [MBProgressHUD hideHUDForView:self.view];
        homeModel *model = [[homeModel alloc] init];
        model.banerListArr = [bannerEntity mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list_banner"]];
        model.preferenceListArr = [ExposureEntity mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list_preference"]];
        model.adverListArr = [ExposureEntity mj_objectArrayWithKeyValuesArray:[result objectForKey:@"list_exposurebar"]];
        self.homemodel = model;
        [self.tableview reloadData];
    } WithFailurBlock:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
//        [MBProgressHUD hideHUDForView:self.view];
    }];

}
#pragma tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2+self.homemodel.adverListArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCellId"];
        cell.ImgView.image=[UIImage imageNamed:@"home_scan"];
        cell.Tiltelab.hidden=YES;
        return cell;
    }
    else if (indexPath.section==1){
        homeHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeHotCellId"];
        cell.modelArr = self.homemodel.preferenceListArr;
        return cell;
    }
    else{
        homeNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeNewCellId"];
        cell.model = self.homemodel.adverListArr[indexPath.section-2];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        ZPSYTabbarVc *tab=(ZPSYTabbarVc*)[UIApplication sharedApplication].keyWindow.rootViewController;
        [tab pushToScanVC];
    }else if (indexPath.section==1){
        return;
    }else{
        ExposureEntity *model = self.homemodel.adverListArr[indexPath.section-2];
        [self exposureDetail:model.jumpUrl webType:model.type ID:model.ID detailStr:model.detail imgStr:model.img];
    }
}

-(void)exposureDetail:(NSString*)urlStr webType:(NSString*)type ID:(NSString*)ID detailStr:(NSString*)detailStr imgStr:(NSString*)imgstr{
    if (![type isEqualToString:@"0"]&&![type isEqualToString:@"1"]&&![type isEqualToString:@"2"]) {
        WKwebVC *web = [[WKwebVC alloc] init];
        web.URLstr = urlStr;
        web.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:web animated:YES];
        return;
    }
    ExposureDetailVC *vc=[[ExposureDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed=YES;
    vc.urlStr = urlStr;
    vc.webtype = type;
    vc.ThatID = ID;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma get
-(UITableView *)tableview{

    if (!_tableview) {
        _tableview=[[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.tableHeaderView=self.sdCycleScrollView;
        [self reloadBanner];
        _tableview.estimatedRowHeight=10;
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.showsHorizontalScrollIndicator=NO;
        [_tableview registerClass:[HomeCell class] forCellReuseIdentifier:@"homeCellId"];
        [_tableview registerClass:[homeHotCell class] forCellReuseIdentifier:@"homeHotCellId"];
        [_tableview registerClass:[homeNewCell class] forCellReuseIdentifier:@"homeNewCellId"];
    }
    return _tableview;
}

-(void)reloadBanner{
    NSMutableArray *arr = [NSMutableArray array];
    [self.homemodel.banerListArr enumerateObjectsUsingBlock:^(bannerEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:obj.img];
    }];
    self.sdCycleScrollView.imageURLStringsGroup=arr;
}
-(SDCycleScrollView *)sdCycleScrollView{

    if (!_sdCycleScrollView) {
        _sdCycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth_fit(174)) delegate:nil placeholderImage:[UIImage imageNamed:PlaceHoldeImageStr]];
        _sdCycleScrollView.imageURLStringsGroup=@[];
        _sdCycleScrollView.autoScrollTimeInterval=5;
        JXWeakSelf(self)
        [_sdCycleScrollView setClickItemOperationBlock:^(NSInteger index) {
            bannerEntity *model = weakSelf.homemodel.banerListArr[index];
            [weakSelf exposureDetail:model.jumpUrl webType:model.type ID:model.ID detailStr:nil imgStr:model.img];
        }];
    }
    return _sdCycleScrollView;
}

-(homeModel *)homemodel{

    if (_homemodel == nil) {
        _homemodel = [[homeModel alloc ] init];
//        NSString * newPath = [[self documentPath] stringByAppendingPathComponent:@"homeModel.plist"];
//        NSData *data = [NSData dataWithContentsOfFile:newPath];
//        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        _homemodel = [unArchiver decodeObjectForKey:@"homeModel"];
//        [unArchiver finishDecoding];
        
    }
    return _homemodel;
}

-(void)setHomemodel:(homeModel *)homemodel{
    _homemodel = homemodel;
    [self reloadBanner];
    [self.tableview reloadData];
//    NSMutableData *mData = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mData];
//    [archiver encodeObject:_homemodel forKey:@"homeModel"];
//    [archiver finishEncoding];
//    NSString *newPath = [[self documentPath] stringByAppendingPathComponent:@"homeModel.plist"];
//    [mData writeToFile:newPath atomically:YES];
}
- (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma other
-(void)resetBut{
    
    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [but setImage:[UIImage imageNamed:@"reset"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:but];
    @weakify(self);
    [[but rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        Setting *setting=[[Setting alloc] initWithStyle:UITableViewStyleGrouped];
        setting.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:setting animated:YES];
    }];
    
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
