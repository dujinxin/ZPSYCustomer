
//
//  MineVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "MineVC.h"
#import "mineloginStatusView.h"
#import "ZPSY-Swift.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *listArr;
}
@property(nonatomic,assign)BOOL hasLogin;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *LoginOutBtn;
@end

@implementation MineVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = mineTile;
    
    
    listArr = @[
                @[
                  @{@"title":@"积分",@"image":@"minescroe"},
                  @{@"title":@"收藏",@"image":@"collect"},
                  @{@"title":@"消息",@"image":@"message"}
                ],
                @[
                  @{@"title":@"举报",@"image":@"report"},
                ]
              ];
    self.hasLogin = [UserManager manager].isLogin;
    
    [RACObserve([UserManager manager], isLogin) subscribeNext:^(id x) {
        if (self.hasLogin != [x boolValue]) {
            self.hasLogin = [x boolValue];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:false];
    
    
    if ([UserManager manager].isLogin) {
        [self userinfoGetRequest];
    }
}
-(void)userinfoGetRequest{

    [BaseSeverHttp ZpsyGetWithPath:Api_GetuserByToken WithParams:nil WithSuccessBlock:^(NSDictionary* dic) {
        BOOL isSuccess = [[UserManager manager] saveAccoundWithDict:dic];
        NSLog(@"%d",isSuccess);
        self.hasLogin=YES;
    } WithFailurBlock:nil];
}
#pragma SET_GET
-(void)setHasLogin:(BOOL)hasLogin{
    _hasLogin = hasLogin;
    self.LoginOutBtn.hidden = !_hasLogin;
    self.tableView.tableHeaderView = [[mineloginStatusView alloc] initWithFrame];
    [self.tableView reloadData];
}

-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.editing = NO;
        _tableView.sectionHeaderHeight = 15;
        _tableView.sectionFooterHeight = 0.01;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UIButton *)LoginOutBtn{

    if (!_LoginOutBtn) {
        _LoginOutBtn = [[UIButton alloc] init];
        [_LoginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _LoginOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _LoginOutBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [_LoginOutBtn setBackgroundColor:[UIColor whiteColor]];
        [_LoginOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _LoginOutBtn.layer.cornerRadius = 8;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
//        view.backgroundColor=[UIColor whiteColor];
        [view addSubview:_LoginOutBtn];
        self.tableView.tableFooterView = view;
        [_LoginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(15, 0, 10, 0));
        }];
        [[_LoginOutBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [[UserManager manager] removeAccound];
        }];
    }
    return _LoginOutBtn;
}

#pragma uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return listArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [listArr objectAtIndex:section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellidentifier"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = listArr[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"image"]];
    if (_hasLogin && indexPath.row == 0 && indexPath.section == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)[UserManager manager].userEntity.score];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_hasLogin) {
    
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                ScoreHistoryVC *scorehistory = [[ScoreHistoryVC alloc] initWithStyle:UITableViewStyleGrouped];
                scorehistory.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:scorehistory animated:YES];
            }else if (indexPath.row == 1){
                CollectionVC *collectionVc = [[CollectionVC alloc] initWithStyle:UITableViewStyleGrouped];
                collectionVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:collectionVc animated:YES];
            }else if (indexPath.row == 2){
                MessageListVC *message = [[MessageListVC alloc] initWithStyle:UITableViewStyleGrouped];
                message.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:message animated:YES];
            }
        }else if (indexPath.section == 1){
        
            if (indexPath.row == 0) {
                ReportListVC *reportListVC = [[ReportListVC alloc] initWithStyle:UITableViewStyleGrouped];
                reportListVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:reportListVC animated:YES];
            }
        }
    }else{
    
        if (indexPath.section == 0 && indexPath.row == 2) {
            MessageListVC *message = [[MessageListVC alloc] initWithStyle:UITableViewStyleGrouped];
            message.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:message animated:YES];
        }else{
            LoginVC * lvc = [[LoginVC alloc] init];
            lvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lvc animated:NO];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
