//
//  BaseSeverHttp.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/4.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "BaseSeverHttp.h"
#import "AFHTTPClient.h"
#import "ZPSYTabbarVc.h"
#import "ZPSYNav.h"
#import "LoginVC.h"
#import "ZPSY-Swift.h"

@implementation BaseSeverHttp

+(void)ZpsyGetWithPath:(NSString*)path WithParams:(id)params
        WithSuccessBlock:(requestSuccessBlock)success
         WithFailurBlock:(requestFailureBlock)failure{

    [[AFHTTPClient sharedManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [BaseSeverHttp SuccessHandle:responseObject WithSuccessBlock:success WithFailurBlock:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseSeverHttp ErrorHandle:error WithErrorBlock:failure];
    }];

}

+(void)ZpsyPostWithPath:(NSString*)path WithParams:(id)params
      WithSuccessBlock:(requestSuccessBlock)success
       WithFailurBlock:(requestFailureBlock)failure{
    
    [[AFHTTPClient sharedManager] POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [BaseSeverHttp SuccessHandle:responseObject WithSuccessBlock:success WithFailurBlock:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseSeverHttp ErrorHandle:error WithErrorBlock:failure];
    }];
}


+(void)afnetForZpsyGetWithPath:(NSString*)path WithParams:(id)params
      WithSuccessBlock:(requestSuccessBlock)success
       WithFailurBlock:(requestFailureBlock)failure{
    
    [[AFHTTPClient sharedManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_SAFE(success)(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_SAFE(failure)(error);
    }];
    
}

+(void)ZpsyDeleteWithPath:(NSString*)path WithParams:(id)params
      WithSuccessBlock:(requestSuccessBlock)success
       WithFailurBlock:(requestFailureBlock)failure{
    
    [[AFHTTPClient sharedManager] DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [BaseSeverHttp SuccessHandle:responseObject WithSuccessBlock:success WithFailurBlock:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [BaseSeverHttp ErrorHandle:error WithErrorBlock:failure];
    }];
}

+(void)SuccessHandle:(id  _Nullable )responseObject WithSuccessBlock:(requestSuccessBlock)success WithFailurBlock:(requestFailureBlock)failure{

    NSDictionary *response = responseObject;
    NSString* errorCode = [response objectForKey:@"errorCode"];
    NSLog(@"responseObject = %@",responseObject);
    
    [MBProgressHUD hideHUD];
    if ([errorCode isEqualToString:@"0"]) {
        BLOCK_SAFE(success)([responseObject objectForKey:@"result"]);
    }else if ([errorCode isEqualToString:@"-2"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationShouldLogin" object:nil];
    }else if ([errorCode isEqualToString:@"-3"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationLoginFromOtherDevice" object:nil];
    }else{
        BLOCK_SAFE(failure)(nil);
        [MBProgressHUD showError:[response objectForKey:@"reason"]];
    }
}


+(void)ErrorHandle:(NSError * _Nonnull) error WithErrorBlock:(requestFailureBlock)failure{
    [MBProgressHUD showError:[BaseSeverHttp getErrorMsssage:error]];
    BLOCK_SAFE(failure)(error);
}

#pragma mark -   获取网络错误信息  基于 afnetwork的error
+(NSString *)getErrorMsssage:(NSError *)error{
    NSLog(@"error: %@",error.localizedDescription);
    // NSURLErrorCancelled
    if(error.code==kCFURLErrorBadServerResponse){
        NSString *string= [error.userInfo objectForKey:@"NSLocalizedDescription"];
        
        NSArray *array=[string  componentsSeparatedByString:@":"];
        string =[array objectAtIndex:array.count-1];
        if(string==nil){
            string=@"内部服务器错误";
        }
        return string;
        
    }else if(error.code == kCFURLErrorTimedOut){
        return @"请求超时";
    }else if(error.code == kCFURLErrorCannotConnectToHost){
        return  @"未能连接到服务器。";
    }else if(error.code ==kCFURLErrorNotConnectedToInternet){
        return @"网络不可用，请检查网络连接";
    }else if(error.code ==3840){
        return @"服务器返回内容错误";
    }
    return @"请检查网络环境!";
}


@end
