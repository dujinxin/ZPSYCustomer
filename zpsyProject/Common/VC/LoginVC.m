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
#import "ZPSYTabbarVc.h"
#import "findeIDViewController.h"
#import "NetWorkTools.h"

@interface LoginVC ()
@property(nonatomic, strong)NSDateFormatter *formatter;
@property(nonatomic, strong)UITextField *nameText;
@property(nonatomic, strong)UITextField *checkCodeText;
@property(nonatomic, strong)UILabel *codelab;
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
    
    [self userinfo];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:false];
}
-(void)userinfo{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signok) name:@"signok" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timeFireMethod) name:@"timeFireMethod" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resultstr:) name:@"resultstr" object:nil];
}
//验证成功
-(void)signok{
    NSLog(@"验证成功了");
}
//连接超时
-(void)timeFireMethod{
    NSLog(@"连接超时");
}
//成功返回的字符串数据
-(void)resultstr:(NSNotification *)info{
    NSLog(@"成功了%@",info.userInfo);
    //[MBProgressHUD showSuccess:@"成功了"];
    
    NSDictionary *dict =@{
                          @"authId":info.userInfo[@"idhash"],
                          @"nickName":@"",
                          @"regType":@(6),
                          @"avatar":@""
                          };
    __block MBProgressHUD *hud= [MBProgressHUD showAnimationtoView:self.view];
    [BaseSeverHttp ZpsyPostWithPath:Api_LoginThird WithParams:dict WithSuccessBlock:^(NSDictionary* result) {
        hud.hidden=YES;
        userInfoModel *model = [userInfoModel mj_objectWithKeyValues:result];
        [UserModel ShareInstance].userInfo = model;
        [UserModel ShareInstance].TOKEN = [result objectForKey:@"token"];
        [UserModel ShareInstance].IsLogin = YES;
        //[self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        BLOCK_SAFE(self.loginSuccessBlock)();
    } WithFailurBlock:^(NSError *error) {
        hud.hidden=YES;
    }];
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
        //[self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    CGFloat space=(kScreenWidth-wid*4)/5;
    NSArray *arr=@[
                   @{@"type":@(UMSocialPlatformType_Sina),
                     @"image":@"loginSina"
                     },
                   @{@"type":@(UMSocialPlatformType_WechatSession),@"image":@"loginWx"},
                   @{@"type":@(UMSocialPlatformType_QQ),
                     @"image":@"loginQQ"
                     },
                   @{@"type":@(1001),
                     @"image":@"loginEID"
                     }
                   ];
    
    [arr enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(((idx+1)*space+idx*wid), Y, wid, wid)];
        [btn setImage:[UIImage imageNamed:obj[@"image"]] forState:UIControlStateNormal];
        if (idx != 3) {
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @weakify(self);
                [UshareGetinfo shareGetInfoWithController:self PlatformType:[arr[idx][@"type"] integerValue] resultBlock:^(UMSocialUserInfoResponse *resp) {
                    @strongify(self);
                    [self thirdClickEventWithType:[arr[idx][@"type"] integerValue] result:resp];
                }];
            }];
        }else{
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                @weakify(self);
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    NSDate *date = [NSDate date];
                    self.formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *biz_time =[self.formatter stringFromDate:date];
                    NSDictionary *dict = @{@"app_id":eIdAppId,@"biz_time":biz_time};
                    
                    NSError * error = nil;
                    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
                    if (error) {
                        NSLog(@"error:%@",error.localizedDescription);
                        return;
                    }
                    NSString * jsonStr = [[NSString alloc ]initWithData:data encoding:NSUTF8StringEncoding];
                    NSMutableString * mutableStr = [NSMutableString stringWithString:jsonStr];
                    [mutableStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, mutableStr.length)];
                    [mutableStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, mutableStr.length)];
                    NSLog(@"mutableStr:%@",mutableStr);
                    [BaseSeverHttp ZpsyPostWithPath:Api_eid WithParams:@{@"plainText":mutableStr} WithSuccessBlock:^(NSDictionary* result) {

                        
                        NSString *app_sign = [[result objectForKey:@"encode"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"app_sign:%@",app_sign);
                       
                        NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
                        [UserDefaults setValue:@"IDH" forKey:@"style"];
                        [UserDefaults setBool:YES forKey:@"PKI"];
                        [UserDefaults setObject:app_sign forKey:@"app_sign"];
                        
                        findeIDViewController *find = [[findeIDViewController alloc] init ];
                        find.APP_id = eIdAppId;
                
                        [self.navigationController pushViewController:find animated:YES];
                        
                    } WithFailurBlock:^(NSError *error) {
                        
                    }];
                    
                });

                

                
            }];
        }
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
    }else{
        //...
        NSLog(@"eID");
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
        //[self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
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
- (NSDateFormatter *)formatter {
    if(! _formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";// twitter date format
    }
    return _formatter;
}
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
        
        if (self.navigationController && [self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
            [self.navigationController popViewControllerAnimated:NO];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
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
    JXWeakSelf(self)
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create( DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        
        weakSelf.codelab.userInteractionEnabled = NO;
        if(!weakSelf)
        {
            dispatch_source_cancel(timer);
        }
        if (timeout<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.codelab.text=@"重新获取";
                weakSelf.codelab.userInteractionEnabled = YES;
            });
        }
        else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.codelab.text=strTime;
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"signok" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"timeFireMethod" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"resultstr" object:nil];
}
@end

