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
    
//    [MBProgressHUD hideHUD];
//    NSDictionary * result = @{
//                              @"ceccGoods": @{
//                                  @"id": @"751df0a4b1d84ff69550b9d3b61954b0",
//                                  @"remarks": @"泰普诺护颈宝360&deg;环绕，全方位支持。不一样的场景，给您同样的多重呵护。内含慢回弹记忆棉枕芯，在支撑颈部的同时放松肩颈肌肉，减缓肩部压力。",
//                                  @"createDate": @"2017-04-07 10:42:06",
//                                  @"updateDate": @"2017-04-08 13:02:27",
//                                  @"name": @"泰普诺护颈宝",
//                                  @"category": @"673adaf42f9f49c4bfaa7bc1f6917299",
//                                  @"thumbnail": @"http://static.izheng.org/image/20170407/CLS3LCFHNH8DR.png",
//                                  @"officeName": @"苏州诺伊曼实业有限公司",
//                                  @"regNo": @"123456789012345",
//                                  @"code": @"",
//                                  @"goodsImg": @"http://static.izheng.org/image/20170407/7V486HPSPUMH1.png,http://static.izheng.org/image/20170407/13DGF73GGPRI5.png,http://static.izheng.org/image/20170407/AVB822QFO1GC1.png",
//                                  @"quality": @"2",
//                                  @"praiseNum": @"0",
//                                  @"list_user": @[],
//                                  @"reportFile": @"http://img.izheng.org/ceccm/20170613/1497336562287,http://static.izheng.org/image/20170407/7V486HPSPUMH1.png,http://static.izheng.org/image/20170407/13DGF73GGPRI5.png,http://static.izheng.org/image/20170407/AVB822QFO1GC1.png",
//                                  @"certificateFile": @"http://img.izheng.org/ceccm/20170613/1497336566670",
//                                  @"favoritesNum": @0,
//                                  @"jumpUrl": @"http://app.izheng.org/#/goodsDetails?id=751df0a4b1d84ff69550b9d3b61954b0",
//                                  @"list_ceccGoodsField": @[
//                                                          @{
//                                                              @"fieldName": @"生产地址",
//                                                              @"fieldValue": @"江苏省太仓市弇山西路151号",
//                                                              @"fieldType": @"0",
//                                                              @"fieldUnit": @"1"
//                                                          },
//                                                          @{
//                                                              @"fieldName": @"包装规格",
//                                                              @"fieldValue": @"http://img.izheng.org/ceccm/20170613/1497336550865",
//                                                              @"fieldType": @"6",
//                                                              @"fieldUnit": @"1"
//                                                          },
//                                                          @{
//                                                              @"fieldName": @"生产企业",
//                                                              @"fieldValue": @"苏州诺伊曼实业有限公司",
//                                                              @"fieldType": @"0",
//                                                              @"fieldUnit": @"1"
//                                                          },
//                                                          @{
//                                                              @"fieldName": @"包装类型",
//                                                              @"fieldValue": @"盒",
//                                                              @"fieldType": @"4",
//                                                              @"fieldUnit": @""
//                                                          },
//                                                          @{
//                                                              @"fieldName": @"原产地",
//                                                              @"fieldValue": @"苏州",
//                                                              @"fieldType": @"0",
//                                                              @"fieldUnit": @"1"
//                                                          },
//                                                          @{
//                                                              @"fieldName": @"主要成分",
//                                                              @"fieldValue": @"外套：100%聚酯纤维  内芯：聚氨酯",
//                                                              @"fieldType": @"0",
//                                                              @"fieldUnit": @"2"
//                                                          }
//                                                          ],
//                                  @"createDateStr": @"2017-04-07 18:42:06",
//                                  @"updateDateStr": @"2017-04-08 21:02:27"
//                              },
//                              @"list_ceccGoodsLotBatch":@[
////                                                         @{
////                                                             @"date": @"2017-04-06 13:47:51",
////                                                             @"event": @"物流销售过程溯源 上海 【上海零压力诺伊曼品牌管理有限公司】发往义乌 操作员 戴兴平"
////                                                         },
////                                                         @{
////                                                             @"date": @"2017-01-30 15:45:50",
////                                                             @"event": @"物流销售过程溯源 江苏省太仓市 出库，发往上海【上海零压力诺伊曼品牌管理有限公司】 操作员 冷书云"
////                                                         },
////                                                         @{
////                                                             @"date": @"2017-01-24 11:41:15",
////                                                             @"event": @"物流销售过程溯源 江苏省太仓市 成品入库，江苏省太仓市弇山2号仓 操作员 冷书云"
////                                                         }
//                                                         ],
//                              @"list_ceccScanrecordForSuspectProduct": @[
//                                                                       @{
//                                                                           @"scanTime": @"2017-05-27 20:44:41.0",
//                                                                           @"city": @"北京",
//                                                                           @"model": @"小米5"
//                                                                       },
//                                                                       @{
//                                                                           @"scanTime": @"2017-05-27 20:33:31.0",
//                                                                           @"city": @"",
//                                                                           @"model": @"iPhone7 设备编码000000000008"
//                                                                       },
//                                                                       @{
//                                                                           @"scanTime": @"2017-05-18 17:08:39.0",
//                                                                           @"city": @"",
//                                                                           @"model": @"小米5"
//                                                                       }
//                                                                       ],
//                              @"list_batch": @[
//                                             @{
//                                                 @"process": @"出厂",
//                                                 @"list_batchField": @[
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497350535733",
//                                                                         @"contents": @"23123",
//                                                                         @"location": @"23测试",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:41:59"
//                                                                     },
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497351005341,http://img.izheng.org/ceccm/20170613/1497351258345,http://img.izheng.org/ceccm/20170613/1497350191679",
//                                                                         @"contents": @"测试超长内容现实问题，内容要长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长",
//                                                                         @"location": @"213",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:34:11"
//                                                                     },
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497349967552",
//                                                                         @"contents": @"考虑进来看",
//                                                                         @"location": @"89898998",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:32:32"
//                                                                     },
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497350191679,http://img.izheng.org/ceccm/20170613/1497344123059",
//                                                                         @"contents": @"乐呵乐呵",
//                                                                         @"location": @"676876",
//                                                                         @"operator": @"329564399@qq.com",
//                                                                         @"operationTime": @"2017-06-13 18:26:09"
//                                                                     },
//                                                                     @{
//                                                                         @"file": @"",
//                                                                         @"contents": @"生产一个无人机",
//                                                                         @"location": @"德国",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-08 15:34:09"
//                                                                     }
//                                                                     ]
//                                             },
//                                             @{
//                                                 @"process": @"出库",
//                                                 @"list_batchField": @[
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497351584643",
//                                                                         @"contents": @"阿萨德",
//                                                                         @"location": @"最后战役",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:59:31"
//                                                                     },
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497351295026",
//                                                                         @"contents": @"123123",
//                                                                         @"location": @"1233成功",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:54:46"
//                                                                     },
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497350254863",
//                                                                         @"contents": @"123",
//                                                                         @"location": @"23123333出库",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:37:20"
//                                                                     }, 
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497349737115",
//                                                                         @"contents": @"123123",
//                                                                         @"location": @"1231233333333",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:28:48"
//                                                                     }, 
//                                                                     @{
//                                                                         @"file": @"",
//                                                                         @"contents": @"我要出库咯",
//                                                                         @"location": @"加利福尼亚",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-08 15:34:56"
//                                                                     }
//                                                                     ]
//                                             }, 
//                                             @{
//                                                 @"process": @"入库",
//                                                 @"list_batchField": @[
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497351258345",
//                                                                         @"contents": @"手动",
//                                                                         @"location": @"12333陈功s",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:54:08"
//                                                                     }, 
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497351005341,http://img.izheng.org/ceccm/20170613/1497351258345,http://img.izheng.org/ceccm/20170613/1497350191679,http://img.izheng.org/ceccm/20170613/1497344123059",
//                                                                         @"contents": @"手动",
//                                                                         @"location": @"1231233扫扫地",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:49:52"
//                                                                     }, 
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497350191679",
//                                                                         @"contents": @"23213",
//                                                                         @"location": @"3131",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 18:36:23"
//                                                                     }, 
//                                                                     @{
//                                                                         @"file": @"http://img.izheng.org/ceccm/20170613/1497344123059",
//                                                                         @"contents": @"我来到花果山",
//                                                                         @"location": @"花果山",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-13 16:55:00"
//                                                                     }, 
//                                                                     @{
//                                                                         @"file": @"",
//                                                                         @"contents": @"顺利到达纽约",
//                                                                         @"location": @"美国",
//                                                                         @"operator": @"神奇女侠",
//                                                                         @"operationTime": @"2017-06-08 15:34:35"
//                                                                     }
//                                                                     ]
//                                             }]
//                              };
//
//    
//    BLOCK_SAFE(success)(result);
    
    if ([errorCode isEqualToString:@"0"]) {
        [MBProgressHUD hideHUD];
        BLOCK_SAFE(success)([responseObject objectForKey:@"result"]);
    }else if ([errorCode isEqualToString:@"-2"]){
        //BLOCK_SAFE(failure)(nil);
        
        [[UserModel ShareInstance] setIsLogin:NO];
        
        ZPSYTabbarVc * rootVc = (ZPSYTabbarVc *)[UIApplication sharedApplication].keyWindow.rootViewController;
        ZPSYNav * nvc = (ZPSYNav *)rootVc.selectedViewController;
        UIViewController * vc = nvc.topViewController;
        LoginVC * lvc = [[LoginVC alloc] init];
        lvc.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:lvc animated:NO];
        
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
