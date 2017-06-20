//
//  LoginVC.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/10.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "LoginVC.h"
#import "loginsortcut.h"
#import "UshareGetinfo.h"
#import "WKwebVC.h"
#import "ZPSYNav.h"

@interface LoginVC ()
@property(nonatomic,strong)UITextField *nameText;
@property(nonatomic,strong)UITextField *checkCodeText;
@property(nonatomic,strong)UILabel *codelab;
@end

@implementation LoginVC

-(void)loadView{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:kScreenBounds];
    [imageView setImage:[UIImage imageNamed:@"LoginBg"]];
    imageView.userInteractionEnabled=YES;
    self.view=imageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self BackBut];
    [self LoginViewinit];
    

    
}
-(void)LoginClickEvent{

    if (![CTUtility isValidateMobile:self.nameText.text]) {
        [MBProgressHUD showError:ErrorMessagePhoneNum];
        return;
    }
    if ([self.checkCodeText.text isEqualToString:@""]) {
        [MBProgressHUD showError:ErrorCheckCode];
        return;
    }
    __block MBProgressHUD *hud= [MBProgressHUD showAnimationtoView:self.view];
    [self.view bringSubviewToFront:VIEWWITHTAG(self.view, 22)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.nameText.text forKey:@"mobile"];
    [params setObject:self.checkCodeText.text forKey:@"password"];
    [BaseSeverHttp ZpsyPostWithPath:Api_Login WithParams:params WithSuccessBlock:^(NSDictionary* result) {
        hud.hidden=YES;
        userInfoModel *model = [userInfoModel mj_objectWithKeyValues:result];
        [UserModel ShareInstance].userInfo = model;
        [UserModel ShareInstance].TOKEN = [result objectForKey:@"token"];
        [UserModel ShareInstance].IsLogin = YES;
        [self dismissViewControllerAnimated:NO completion:nil];
        BLOCK_SAFE(self.loginSuccessBlock)();
    } WithFailurBlock:^(NSError *error) {
        hud.hidden=YES;
    }];
    
}


#pragma View 初始化
-(void)LoginViewinit{

    [self.view addSubview:self.nameText];
    [self.view addSubview:self.checkCodeText];
    
    UIButton *loginBtn=[[UIButton alloc] init];
    loginBtn.tag=22;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius=22;
    loginBtn.layer.backgroundColor=[UIColor colorWithWhite:1 alpha:0.65].CGColor;
    [loginBtn addTarget:self action:@selector(LoginClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.top.mas_equalTo(self.view.mas_top).offset(kWidth_fit(248));
        make.height.equalTo(@30);
    }];
    [self.checkCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.top.mas_equalTo(self.nameText.mas_bottom).offset(20);
        make.height.equalTo(@30);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.top.mas_equalTo(self.checkCodeText.mas_bottom).offset(kWidth_fit(35));
        make.height.equalTo(@44);
    }];
    
    [self thirdLoginlInit];
}

-(void)thirdLoginlInit{

    loginsortcut *shortcut=[[loginsortcut alloc] initWithFrame:CGRectMake(0, kWidth_fit(480), kScreenWidth, 16)];
    shortcut.backgroundColor=[UIColor clearColor];
    [self.view addSubview:shortcut];

    CGFloat Y=CGRectGetMaxY(shortcut.frame)+kWidth_fit(15);
    CGFloat wid=kWidth_fit(80);
    CGFloat space=(kScreenWidth-wid*3)/4;
    NSArray *arr=@[
                   @{@"type":@(UMSocialPlatformType_Sina),
                     @"image":@"thirdewb"
                     },
                   @{@"type":@(UMSocialPlatformType_WechatSession),@"image":@"thirdewx"},
                   @{@"type":@(UMSocialPlatformType_QQ),
                     @"image":@"thirdeqq"
                     },
                   ];
    
    [arr enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(((idx+1)*space+idx*wid), Y, wid, wid)];
        [btn setImage:[UIImage imageNamed:obj[@"image"]] forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @weakify(self);
            [UshareGetinfo shareGetInfoWithController:self PlatformType:[arr[idx][@"type"] integerValue] resultBlock:^(UMSocialUserInfoResponse *resp) {
                @strongify(self);
                [self thirdClickEventWithType:[arr[idx][@"type"] integerValue] result:resp];
            }];
        }];
        [self.view addSubview:btn];
    }];
    
    //协议
    UILabel *label=[[UILabel alloc] init];
    label.text=@"登录即代表同意《用户协议》";
    label.font=kFont_7;
    label.textColor=kColor_2;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(kWidth_fit(-40));
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolShow)];
    label.userInteractionEnabled=YES;
    [label addGestureRecognizer:tap];
}
//Api_LoginThird
-(void)thirdClickEventWithType:(UMSocialPlatformType)type result:(UMSocialUserInfoResponse*)resp{
    
    NSInteger regType = 1;
    
    if (type==UMSocialPlatformType_Sina) {
        regType = 4;
    }else if (type==UMSocialPlatformType_WechatSession){
        regType = 2;
    }else if (type==UMSocialPlatformType_QQ){
        regType = 3;
    }
    
     NSDictionary *dict =@{
        @"authId":resp.uid,
        @"nickName":resp.name,
        @"regType":@(regType),
        @"avatar":resp.iconurl
        };
     __block MBProgressHUD *hud= [MBProgressHUD showAnimationtoView:self.view];
    [BaseSeverHttp ZpsyPostWithPath:Api_LoginThird WithParams:dict WithSuccessBlock:^(NSDictionary* result) {
        hud.hidden=YES;
        userInfoModel *model = [userInfoModel mj_objectWithKeyValues:result];
        [UserModel ShareInstance].userInfo = model;
        [UserModel ShareInstance].TOKEN = [result objectForKey:@"token"];
        [UserModel ShareInstance].IsLogin = YES;
        [self dismissViewControllerAnimated:NO completion:nil];
        BLOCK_SAFE(self.loginSuccessBlock)();
    } WithFailurBlock:^(NSError *error) {
        hud.hidden=YES;
    }];
    
}

-(void)protocolShow{
    WKwebVC *web=[[WKwebVC alloc] init];
    web.URLstr = [NSString stringWithFormat:@"%@agreement",HtmlBasUrl];
    ZPSYNav *nav=[[ZPSYNav alloc] initWithRootViewController:web];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma get
-(UITextField *)nameText{

    if (!_nameText) {
        _nameText=[[UITextField alloc] init];
        _nameText.placeholder=@"请输入手机号";
        _nameText.keyboardType=UIKeyboardTypeNumberPad;
        _nameText.clearButtonMode=UITextFieldViewModeAlways;
        _nameText.backgroundColor=[UIColor clearColor];
        _nameText.textColor=[UIColor whiteColor];
        UIView *line=[self LineView];
        [_nameText addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameText);
            make.right.mas_equalTo(_nameText);
            make.bottom.mas_equalTo(_nameText);
            make.height.equalTo(@1);
        }];
    }
    return _nameText;
}


-(UITextField *)checkCodeText{

    if (!_checkCodeText) {
        _checkCodeText=[[UITextField alloc] init];
        _checkCodeText.placeholder=@"验证码";
        _checkCodeText.keyboardType=UIKeyboardTypeNumberPad;
        _checkCodeText.clearButtonMode=UITextFieldViewModeAlways;
        _checkCodeText.backgroundColor=[UIColor clearColor];
        _checkCodeText.rightViewMode=UITextFieldViewModeAlways;
        _checkCodeText.rightView=self.codelab;
        _checkCodeText.textColor=[UIColor whiteColor];
        UIView *line=[self LineView];
        [_checkCodeText addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_checkCodeText);
            make.right.mas_equalTo(_checkCodeText);
            make.bottom.mas_equalTo(_checkCodeText);
            make.height.equalTo(@1);
        }];
    }
    return _checkCodeText;
}
-(UILabel *)codelab{
    if (!_codelab) {
        _codelab=[[UILabel alloc] init];
        _codelab.text=@"立即获取";
        _codelab.textColor=[UIColor whiteColor];
        _codelab.font=[UIFont systemFontOfSize:15];
        _codelab.textAlignment=NSTextAlignmentCenter;
        _codelab.backgroundColor=[UIColor clearColor];
        _codelab.width=70;
        _codelab.height=40;
        _codelab.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkCodeBtnClickEvent)];
        [_codelab addGestureRecognizer:tap];
    }
    return _codelab;
}

-(UIView*)LineView{
    UIView *line=[[UIView alloc] init];
    line.backgroundColor=[UIColor whiteColor];
    return line;
}


-(void)BackBut{
    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"difference"] forState:UIControlStateNormal];
    [self.view addSubview:but];
    @weakify(self);
    [[but rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)checkCodeBtnClickEvent{
    if (![CTUtility isValidateMobile:self.nameText.text]) {
        [MBProgressHUD showError:ErrorMessagePhoneNum];
        return;
     }
    [self startTime];
    [BaseSeverHttp ZpsyGetWithPath:Api_getAuthorizationCode WithParams:@{@"mobile":self.nameText.text,@"type":@"1"} WithSuccessBlock:^(id result) {
        [MBProgressHUD showSuccess:SuccessCheckCode];
    } WithFailurBlock:^(NSError *error) {
    }];
}

#pragma 倒计时时间
-(void)startTime
{
    //倒计时时间
    __block int timeout = 60;
    //设置全局队列
    @weakify(self);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create( DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        @strongify(self);
        self.codelab.userInteractionEnabled = NO;
        if(!self)
        {
            dispatch_source_cancel(timer);
        }
        if (timeout<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.codelab.text=@"重新获取";
                self.codelab.userInteractionEnabled = YES;
            });
        }
        else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.codelab.text=strTime;
            });
            timeout--;
            
        }
    });
    dispatch_resume(timer);
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
