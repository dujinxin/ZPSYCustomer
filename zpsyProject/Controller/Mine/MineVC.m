
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
                  @{@"title":@"积分",@"image":@"my_score"},
                  @{@"title":@"收藏",@"image":@"my_collect"},
                  @{@"title":@"消息",@"image":@"my_message"}
                ],
                @[
                  @{@"title":@"举报",@"image":@"my_report"},
                ]
              ];
    
    self.hasLogin = [UserManager manager].isLogin;
    //FIXME:第一次进入该页面时，同时已经被踢，那么会同时调用监听和wiewwillappear,会调用两次
    [RACObserve([UserManager manager], isLogin) subscribeNext:^(id x) {
        self.hasLogin = [x boolValue];
        if ([UserManager manager].isLogin) {
            [self userinfoGetRequest];
        }
    }];
}
/*
 1.公司目前基本是单岗单人，缺少一些技术或者经验的交流，是否可以增加一些培训，或者外出参加行业技术的交流会等
 2.增加一些员工福利，比如一年一次的旅游，一年一次的体检
 3.公司的补贴是否可以通过现金（或者其他不与工资一起发放的方式）的形式发放
 4.
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:false];
    
    if ([UserManager manager].isLogin) {
        [self userinfoGetRequest];
    }
}
- (void)userinfoGetRequest{

    [BaseSeverHttp ZpsyGetWithPath:Api_GetuserByToken WithParams:nil WithSuccessBlock:^(NSDictionary* dic) {
        BOOL isSuccess = [[UserManager manager] saveAccoundWithDict:dic];
        NSLog(@"%d",isSuccess);
        //self.hasLogin = YES;
    } WithFailurBlock:^(NSError *error) {
        //self.hasLogin = NO;
    }];
}
#pragma SET_GET
- (void)setHasLogin:(BOOL)hasLogin{
    _hasLogin = hasLogin;
    
    self.LoginOutBtn.hidden = !_hasLogin;
    self.tableView.tableHeaderView = [[mineloginStatusView alloc] initWithFrame];
    [self.tableView reloadData];
}

- (UITableView *)tableView{

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
        _LoginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
            [UserManager manager].isLogin = false;
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
