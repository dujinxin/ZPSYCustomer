//
//  ExposureDetailVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/27.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "ExposureDetailVC.h"
#import "ExposureDetailView.h"
#import "ShareViewModel.h"
#import "UShareView.h"
#import "ZPSY-Swift.h"
#import "LoginVC.h"
@interface ExposureDetailVC ()

@property(nonatomic, strong)ExposureDetailView *detailView;
@property(nonatomic,strong)UIButton *collectionBtn;

@end

@implementation ExposureDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"文章详情";
    [self rightBtnset];
    [self viewinit];
    [self isfaverite];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserModel ShareInstance].IsLogin) {
        self.detailView.UrlStr = [NSString stringWithFormat:@"%@&token=%@",self.urlStr,[UserModel ShareInstance].TOKEN];
    }else{
        self.detailView.UrlStr = self.urlStr;
    }
}
-(void)viewinit{
    
    NSArray *urlArr = [self.urlStr componentsSeparatedByString:@"?"];
    if (urlArr.count>1) {
        NSString * queStr = urlArr[1];
        NSArray * arr = [queStr componentsSeparatedByString:@"&"];
        [arr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray* array = [obj componentsSeparatedByString:@"="];
            if (array.count>1) {
                if ([array[0] isEqualToString:@"id"]) {
                    self.ThatID = array[1];
                    *stop = YES;
                }
            }
        }];

    }
    
    @weakify(self)
    [self.detailView setEnventDoBlock:^(NSString *str) {
        @strongify(self)
        if (str) {
            if ([str isEqualToString:@"login"]) {
                [self loginPush];
            }else if ([str isEqualToString:@"comment"]){
                HotRemarkVC *vc = [[HotRemarkVC alloc] init];
                vc.resourcesId = self.ThatID;
                vc.objectcCommentType = self.webtype;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
//    CommentInputView* inputview=[[CommentInputView alloc] init:YES];
//    [self.view addSubview:inputview];
//    [inputview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.top.mas_equalTo(self.detailView.mas_bottom);
//    }];
}







#pragma GET
-(ExposureDetailView *)detailView{
    if (!_detailView) {
        
        _detailView=[[ExposureDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:_detailView];
    }
    return _detailView;
}

-(UIButton *)collectionBtn{

    if (!_collectionBtn) {
        
        _collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
        [_collectionBtn setImage:[UIImage imageNamed:@"whitecollection"] forState:UIControlStateNormal];
        [_collectionBtn addTarget:self action:@selector(collectionsBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
        _collectionBtn.tag = 10;
    }
    return _collectionBtn;
}

-(void)rightBtnset{
    
    UIBarButtonItem *bar_1 = [[UIBarButtonItem alloc] initWithCustomView:self.collectionBtn];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 32)];
    [btn setImage:[UIImage imageNamed:@"whiteShare"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareFun) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_2 = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[bar_2,bar_1];
    
}

-(void)isfaverite{

    if ([UserModel ShareInstance].IsLogin) {
        [BaseSeverHttp ZpsyGetWithPath:Api_isFavorites WithParams:@{@"resourceId":self.ThatID} WithSuccessBlock:^(NSString* result) {
            if ([result isEqualToString:@"-1"]){
                [self.collectionBtn setImage:[UIImage imageNamed:@"whitFullcollect"] forState:UIControlStateNormal];
                self.collectionBtn.tag = 11;
            }else{
                [self.collectionBtn setImage:[UIImage imageNamed:@"whitecollection"] forState:UIControlStateNormal];
                self.collectionBtn.tag = 10;
            }
            
        } WithFailurBlock:^(NSError *error) {
            
        }];
    }
}

-(void)collectionsBtnClickEvent{

    if (![UserModel ShareInstance].IsLogin) {
        [self loginPush];
        return;
    }

    if (self.webtype ==nil || (![self.webtype isEqualToString:@"0"] &&![self.webtype isEqualToString:@"1"] && ![self.webtype isEqualToString:@"2"])) {
        return;
    }

    NSString *flag = @"0";
    if (self.collectionBtn.tag == 11) {
        flag = @"1";
    }
    
    [MBProgressHUD showAnimationtoView:self.view];
    [BaseSeverHttp ZpsyGetWithPath:Api_userFavorites WithParams:@{@"resourceId":self.ThatID,@"flag":flag,@"type":self.webtype} WithSuccessBlock:^(id result) {
        [MBProgressHUD hideHUDForView:self.view];
        if (self.collectionBtn.tag == 10) {
            [MBProgressHUD showSuccess:@"收藏成功"];
            [self.collectionBtn setImage:[UIImage imageNamed:@"whitFullcollect"] forState:UIControlStateNormal];
            self.collectionBtn.tag = 11;
        }else{
        
            [MBProgressHUD showSuccess:@"已取消收藏"];
            [self.collectionBtn setImage:[UIImage imageNamed:@"whitecollection"] forState:UIControlStateNormal];
            self.collectionBtn.tag = 10;
            
        }
        
    } WithFailurBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (self.collectionBtn.tag == 10) {
            [self.collectionBtn setImage:[UIImage imageNamed:@"whitFullcollect"] forState:UIControlStateNormal];
            self.collectionBtn.tag = 11;
        }else{
            [self.collectionBtn setImage:[UIImage imageNamed:@"whitecollection"] forState:UIControlStateNormal];
            self.collectionBtn.tag = 10;
            
        }
    }];
}

// 分享
-(void)shareFun{
    
    if (![UserModel ShareInstance].IsLogin) {
        [self loginPush];
        return;
    }
    
    ShareViewModel* shareModel = [[ShareViewModel alloc] init];
    shareModel.Title = self.title;
    shareModel.DesText = self.detilStr;
    shareModel.UrlStr = self.urlStr;
    shareModel.icon = self.imgStr;
    UShareView* shareview = [[UShareView alloc] initWithModel:shareModel];
    __weak typeof(shareview) weakshareview = shareview;
    [shareview setShareresult:^(NSError *err) {
        [weakshareview Hidden];
        if (err != nil) {
            [MBProgressHUD showError:@"分享失败"];
            return ;
        }
        [BaseSeverHttp ZpsyGetWithPath:Api_userScoreChange WithParams:@{@"type":@"4"} WithSuccessBlock:nil WithFailurBlock:nil];
    }];
    [shareview Show];
}

-(void)loginPush{
    LoginVC *login = [[LoginVC alloc] init];
    @weakify(self)
    [login setLoginSuccessBlock:^{
        @strongify(self)
        self.detailView.UrlStr = [NSString stringWithFormat:@"%@&token=%@",self.urlStr,[UserModel ShareInstance].TOKEN];
        [self isfaverite];
    }];
    [self presentViewController:login animated:YES completion:nil];
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
