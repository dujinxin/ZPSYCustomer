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

@interface ExposureVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger pageno;
    NSMutableArray *dataList;
}
@property(nonatomic,strong)UITableView *MyTableView;
@end

@implementation ExposureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=exposureTile;
    [self.MyTableView registerClass:[CollectionExposureCell class] forCellReuseIdentifier:@"CollectionExposureCellID"];
    pageno=1;
    dataList=[NSMutableArray array];
    
    @weakify(self)
    self.MyTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        pageno=1;
        [self datarequest];
    }];
    [self.MyTableView.mj_header beginRefreshing];
    self.MyTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        pageno+=1;
        [self datarequest];
    }];
}
-(void)datarequest{

    [BaseSeverHttp ZpsyGetWithPath:Api_GetExposureList WithParams:@{@"pageNo":@(pageno)} WithSuccessBlock:^(NSArray* result) {
        [self.MyTableView.mj_header endRefreshing];
        [self.MyTableView.mj_footer endRefreshing];
        if (pageno==1) {
            dataList = [exposureModel mj_objectArrayWithKeyValuesArray:result];
        }else{
            [dataList addObjectsFromArray:[exposureModel mj_objectArrayWithKeyValuesArray:result]];
        }
        [self.MyTableView reloadData];
    } WithFailurBlock:^(NSError *error) {
        [self.MyTableView.mj_header endRefreshing];
        [self.MyTableView.mj_footer endRefreshing];
    }];
}

#pragma tableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionExposureCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CollectionExposureCellID"];
    cell.mycommentType = @"1";
    cell.model=dataList[indexPath.row];
    return cell;
}

#pragma GET
-(UITableView *)MyTableView{

    if (!_MyTableView) {
        _MyTableView=[[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
        _MyTableView.estimatedRowHeight=10;
        _MyTableView.rowHeight=UITableViewAutomaticDimension;
        _MyTableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _MyTableView.delegate=self;
        _MyTableView.dataSource=self;
        [self.view addSubview:self.MyTableView];
    }
    return _MyTableView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    exposureModel *model=dataList[indexPath.row];
    ExposureDetailVC *Vc=[[ExposureDetailVC alloc] init];
    Vc.urlStr = model.jumpUrl;
    Vc.ThatID = model.ID;
    Vc.webtype = model.field3;
    Vc.detilStr = model.detail;
    Vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Vc animated:YES];
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
