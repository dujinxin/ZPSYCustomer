//
//  ExposureVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ExposureVC.h"
#import "ZPSY-Swift.h"
#import "ExposureDetailVC.h"
#import "HistoryVC.h"

@interface ExposureVC ()<UITableViewDelegate,UITableViewDataSource,JXTopBarViewDelegate,JXHorizontalViewDelegate>{
    NSInteger pageno;
    NSMutableArray *dataList;
}
@property(nonatomic, strong)UITableView * MyTableView;
@property(nonatomic, strong)JXTopBarView * topBar;
@property(nonatomic, strong)JXHorizontalView * horizontalView;
@end

@implementation ExposureVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = exposureTile;
    
    self.topBar = [[JXTopBarView alloc ] initWithFrame:CGRectMake(0, kNavStatusHeight, self.view.bounds.size.width, 44) titles:@[@"曝光",@"行业资讯",@"正品动态"]];
    self.topBar.delegate = self;
    self.topBar.isBottomLineEnabled = YES;
    self.topBar.layer.shadowColor = JXColorFromRGB(0xc3c3c3).CGColor;//阴影颜色
    self.topBar.layer.shadowOffset = CGSizeMake(0, 1);//阴影偏移量
    self.topBar.layer.shadowOpacity = 0.3;//阴影透明度
    self.topBar.layer.shadowRadius = 3;//阴影半径
    [self.view addSubview:self.topBar];
    
    ExposureViewController * vc1 = [[ExposureViewController alloc ] init ];
    ExposureViewController * vc2 = [[ExposureViewController alloc ] init ];
    ExposureViewController * vc3 = [[ExposureViewController alloc ] init ];
    vc1.newsType = 1;
    vc2.newsType = 2;
    vc3.newsType = 3;
    
    self.horizontalView = [[JXHorizontalView alloc ] initWithFrame:CGRectMake(0, kNavStatusHeight + 45, self.view.bounds.size.width, kScreenHeight - kNavStatusHeight -kTabBarHeight - 45) containers:@[vc1,vc2,vc3] parentViewController:self];
    [self.view addSubview:self.horizontalView];
}
- (void)jxTopBarViewWithTopBarView:(JXTopBarView *)topBarView didSelectTabAt:(NSInteger)index{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    //开启动画会影响topBar的点击移动动画
    [self.horizontalView.containerView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
- (void)horizontalViewDidScrollWithScrollView:(UIScrollView *)scrollView{
    CGRect rect = self.topBar.bottomLineView.frame;
    CGFloat offset = scrollView.contentOffset.x;
    rect.origin.x = (offset / kScreenWidth ) * (kScreenWidth / 3);
    self.topBar.bottomLineView.frame = rect;
}
- (void)horizontalView:(JXHorizontalView *)_ to:(NSIndexPath *)indexPath{
    self.topBar.selectedIndex = indexPath.item;
    [self.topBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)obj;
            if (button.tag != self.topBar.selectedIndex) {
                button.selected = NO;
            }else{
                button.selected = YES;
            }
        }
    }];
}
#pragma UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionExposureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionExposureCellID" forIndexPath:indexPath];
    cell.mycommentType = @"1";
    cell.model=dataList[indexPath.row];
    return cell;
}

#pragma GET
- (UITableView *)MyTableView{
    if (!_MyTableView) {
        _MyTableView = [[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
        _MyTableView.estimatedRowHeight = 10;
        _MyTableView.rowHeight = UITableViewAutomaticDimension;
        _MyTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _MyTableView.delegate = self;
        _MyTableView.dataSource = self;
    }
    return _MyTableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    exposureModel *model = dataList[indexPath.row];
    ExposureDetailVC *Vc = [[ExposureDetailVC alloc] init];
    Vc.urlStr = model.jumpUrl;
    Vc.ThatID = model.ID;
    Vc.webtype = model.field3;
    Vc.detilStr = model.detail;
    Vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
