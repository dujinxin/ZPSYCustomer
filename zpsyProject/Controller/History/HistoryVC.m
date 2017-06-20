//
//  HistoryVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "HistoryVC.h"
#import "ZPSY-Swift.h"

@interface HistoryVC ()<UITableViewDelegate,UITableViewDataSource>{

    NSInteger PageNo;
    NSMutableArray *listArr;
}
@property(nonatomic, strong)UITableView *tableview;
@end

@implementation HistoryVC
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=histotyTile;
    [self trashRightBtninit];
    [self.view addSubview:self.tableview];
    listArr = [NSMutableArray array];
    PageNo=1;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        PageNo=1;
        [self dataRequest];
    }];
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        PageNo+=1;
        [self dataRequest];
    }];
    
}

-(void)dataRequest{

    [BaseSeverHttp ZpsyGetWithPath:Api_scanRecordList WithParams:@{@"pageNo":@(PageNo)} WithSuccessBlock:^(id result) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        NSArray *arr = [productModel mj_objectArrayWithKeyValuesArray:result];
        if (PageNo==1) {
            listArr = [NSMutableArray arrayWithArray:arr];
        }else{
            [listArr addObjectsFromArray:arr];
        }
        [self.tableview reloadData];
    } WithFailurBlock:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
    }];

}


//删除
-(void)trashBtnClickEvent{

    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"您确定删除所有历史记录么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteAll];
    }];
    UIAlertAction *cancell = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancell];
    [alert addAction:OkAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)deleteAll{
    [MBProgressHUD showAnimationtoView:self.view];
    [BaseSeverHttp ZpsyGetWithPath:Api_scanRecordDeleteAll WithParams:nil WithSuccessBlock:^(id result) {
        [MBProgressHUD hideHUDForView:self.view];
        listArr=[NSMutableArray array];
        [self.tableview reloadData];
    } WithFailurBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}


#pragma tablview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ReportCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReportCellId"];
    productModel* model = [listArr objectAtIndex:indexPath.row];
//    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:[model getfirstGoodImg]] placeholderImage:[UIImage imageNamed:PlaceHoldeImageStr]];
//    cell.textlab.text = model.goodsName;
//    cell.timerlab.text = [CTUtility stringFromString:model.createDateStr sourceformat:@"yyyy-MM-dd HH:mm:ss" toFormat:@"yyyy-MM-dd"];
//    [cell.LogoImg sd_setImageWithURL:[NSURL URLWithString:[model thumbnail]] placeholderImage:[UIImage imageNamed:PlaceHoldeImageStr]];
    HistoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HistoryCellId"];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    productModel* model = [listArr objectAtIndex:indexPath.row];
    ProductDetailVC* productdetail= [[ProductDetailVC alloc] init];
    productdetail.ProductID = model.ID;
    productdetail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productdetail animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        productModel *model = [listArr objectAtIndex:indexPath.row];
        [listArr removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        [BaseSeverHttp ZpsyGetWithPath:Api_scanRecordDeleteById WithParams:@{@"goodsId":model.ID} WithSuccessBlock:^(id result) {
        } WithFailurBlock:nil];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
#pragma GET
-(UITableView *)tableview{

    if (!_tableview) {
        _tableview=[[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
        _tableview.estimatedRowHeight=10;
        _tableview.rowHeight=UITableViewAutomaticDimension;
        _tableview.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        [_tableview registerClass:[HistoryCell class] forCellReuseIdentifier:@"HistoryCellId"];
        _tableview.sectionFooterHeight=0.01;
        _tableview.sectionHeaderHeight=8;
    }
    return _tableview;
}

/**
 删除按钮设置
 */
-(void)trashRightBtninit{

    UIImage *backButtonTheme = [UIImage imageNamed:@"trash"];
    backButtonTheme = [backButtonTheme imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backButtom = [[UIBarButtonItem alloc] initWithImage:backButtonTheme style:UIBarButtonItemStyleDone target:self action:@selector(trashBtnClickEvent)];
    self.navigationItem.rightBarButtonItem = backButtom;

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
