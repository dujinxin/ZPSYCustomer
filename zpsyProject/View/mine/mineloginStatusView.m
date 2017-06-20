//
//  mineloginStatusView.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/14.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "mineloginStatusView.h"
#import "LoginVC.h"
#import "ZPSY-Swift.h"

@interface mineloginStatusView ()
@property(nonatomic,strong)UIButton* headPortrait;
@property(nonatomic,strong)UIButton*loginBtn;
@property(nonatomic,strong)UILabel *Namelab;
@property(nonatomic,strong)UILabel *QualityNum;
@end

@implementation mineloginStatusView

-(instancetype)initWithFrame{
    CGRect frame=CGRectMake(0, 0, kScreenWidth, kWidth_fit(150)+30);
    if ([UserModel ShareInstance].IsLogin) {
        frame=CGRectMake(0, 0, kScreenWidth, kWidth_fit(84)+30);
    }
    self=[super initWithFrame:frame];
    if (self) {
        if ([UserModel ShareInstance].IsLogin) {
            [self LoginInInitview];
        }else{
            [self LoginOutInitview];
        }
    }
    return self;
}
//登录
-(void)LoginInInitview{
    
    UIView *imageview=[[UIView alloc] init];
    imageview.backgroundColor=[UIColor whiteColor];
    imageview.userInteractionEnabled=YES;
    [self addSubview:imageview];
    
    [imageview addSubview:self.headPortrait];
    [imageview addSubview:self.Namelab];
    [imageview addSubview:self.QualityNum];
    [self.headPortrait sd_setImageWithURL:[NSURL URLWithString:[UserModel ShareInstance].userInfo.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PlaceHoldeImageStr]];
    
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(15, 0, 15, 0));
    }];
    
    [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageview.mas_left).offset(15);
        make.centerY.mas_equalTo(imageview);
        make.size.mas_equalTo(CGSizeMake(kWidth_fit(54), kWidth_fit(54)));
    }];
    
    [self.Namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageview.mas_top).offset(15);
        make.left.mas_equalTo(_headPortrait.mas_right).offset(10);
    }];
    
    [self.QualityNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.Namelab.mas_bottom).offset(8);
        make.left.mas_equalTo(_headPortrait.mas_right).offset(10);
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(EditEventClick)];
    [imageview addGestureRecognizer:tap];
}
-(void)EditEventClick{

    UserInfoEditVC *userinfo=[[UserInfoEditVC alloc] initWithStyle:UITableViewStyleGrouped];
    userinfo.hidesBottomBarWhenPushed=YES;
    [[CTUtility findViewController:self].navigationController pushViewController:userinfo animated:YES];

}
//退出
-(void)LoginOutInitview{
    UIImageView *imageview=[[UIImageView alloc] init];
    imageview.userInteractionEnabled=YES;
    [imageview setImage:[UIImage imageNamed:@"mineBg"]];
    [self addSubview:imageview];
    
    [imageview addSubview:self.headPortrait];
    [imageview addSubview:self.loginBtn];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(15, 0, 15, 0));
    }];
    
    [self.headPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageview.mas_top).offset(kWidth_fit(15));
        make.centerX.mas_equalTo(imageview);
        make.size.mas_equalTo(CGSizeMake(kWidth_fit(80), kWidth_fit(80)));
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headPortrait.mas_bottom).offset(kWidth_fit(10));
        make.centerX.mas_equalTo(imageview);
    }];
 
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[LoginVC new] animated:YES completion:nil];
    }];
    
}



#pragma get
-(UIButton *)headPortrait{

    if (!_headPortrait) {
        _headPortrait=[[UIButton alloc] init];
        CGFloat w=80;
        if ([UserModel ShareInstance].IsLogin) {
            w=54;
        }
        _headPortrait.layer.cornerRadius=kWidth_fit(w)/2.0;
        _headPortrait.layer.backgroundColor=[UIColor groupTableViewBackgroundColor].CGColor;
        [_headPortrait sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PlaceHoldeImageStr]];
    }
    return _headPortrait;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[[UIButton alloc] init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _loginBtn;
}

-(UILabel *)Namelab{
    if (!_Namelab) {
        _Namelab=[[UILabel alloc] init];
        _Namelab.font=kFont_1;
        _Namelab.text=[UserModel ShareInstance].userInfo.nickName? [UserModel ShareInstance].userInfo.nickName : @" ";
    }
    return _Namelab;

}
-(UILabel *)QualityNum{

    if (!_QualityNum) {
        _QualityNum=[[UILabel alloc] init];
        _QualityNum.font=kFont_5;
        _QualityNum.textColor=kColor_6;
        _QualityNum.text=[NSString stringWithFormat:@"正品号：%@",[UserModel ShareInstance].userInfo.genuid ? [UserModel ShareInstance].userInfo.genuid : @" "];
    }
    return _QualityNum;

}

@end
