//
//  UserModel.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/10.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "UserModel.h"


@implementation userInfoModel
@synthesize avatar=_avatar,nickName = _nickName,mobile=_mobile;

-(NSString *)avatar{
    
    if (_avatar==nil) {
        _avatar=@"";
    }
    return _avatar;
}
-(NSString *)nickName{
    
    if (_nickName==nil) {
        _nickName=@"";
    }
    return _nickName;
}
-(NSString *)mobile{

    if (_mobile==nil) {
        return @"";
    }
    return _mobile;
}
@end

@interface  UserModel (){
}
@end

@implementation UserModel
@synthesize IsLogin=_IsLogin,userInfo=_userInfo,TOKEN = _TOKEN;

+(instancetype)ShareInstance{
    static UserModel*User=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        User=[[UserModel alloc] init];
    });
    return User;
}

-(void)setIsLogin:(BOOL)IsLogin{
    [[NSUserDefaults standardUserDefaults] setObject:@(IsLogin) forKey:@"zpsyhaslogin"];
    _IsLogin=IsLogin;
}
-(BOOL)IsLogin{
    id objc= [[NSUserDefaults standardUserDefaults] objectForKey:@"zpsyhaslogin"];
    _IsLogin=YES;
    if (objc==nil||[objc boolValue]==NO) {
        _IsLogin=NO;
    }
    return _IsLogin;
}

-(void)setUserInfo:(userInfoModel *)userInfo{
    _userInfo = userInfo;
}

-(userInfoModel *)userInfo{

    if (_userInfo==nil) {
        _userInfo = [[userInfoModel alloc] init];
    }
    return _userInfo;
}

-(void)setTOKEN:(NSString *)TOKEN{

    [[NSUserDefaults standardUserDefaults] setObject:TOKEN forKey:@"zpsyLoginToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _TOKEN = TOKEN;
}
-(NSString *)TOKEN{

    if (!self.IsLogin) {
        return @"";
    }
    
    _TOKEN= [[NSUserDefaults standardUserDefaults] objectForKey:@"zpsyLoginToken"];
    if (_TOKEN==nil||[_TOKEN isEqualToString:@""]) {
        _TOKEN=@"";
    }
    return _TOKEN;

}

@end
