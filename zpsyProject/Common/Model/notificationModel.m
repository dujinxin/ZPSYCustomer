//
//  notificationModel.m
//  ZPSY
//
//  Created by zhouhao on 2017/4/4.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "notificationModel.h"
#import "ZPSY-Swift.h"
#import "WKwebVC.h"
#import "ZPSYNav.h"
@interface notificationModel()
@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *host;
@property(nonatomic,strong)NSString *jumpurl;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *detail;

@end

@implementation notificationModel
//{
//    "_j_msgid" = 5702957031;
//    aps =     {
//        alert = "\U8fd9\U662f\U6807\U9898";
//        badge = 5;
//        sound = "";
//    };
//    title = "\U6d4b\U8bd5\U6807\U9898\U3002";
//    url = "zpsy://push/msg?url=http://www.baidu.com&type=1&id=4&img=http://www.baidu.com&detail=\U6d4b\U8bd5\U901a\U77e5\U683c\U5f0f&extra=\U5176\U4ed6\U4fe1\U606f";
//}


-(void)initdatawithDict:(NSDictionary*)dict{

    self.title = [dict objectForKey:@"title"];
    NSString *urlStr = [dict objectForKey:@"url"];
    NSURL *url = [NSURL URLWithString:urlStr];
    self.host = url.host;
    
    NSDictionary *Mydict = [self quaryGetWithUrlsStr:urlStr];
    
    self.jumpurl = [self getValueFromDict:Mydict Key:@"url"];
    self.type = [self getValueFromDict:Mydict Key:@"type"];
    self.ID = [self getValueFromDict:Mydict Key:@"id"];
    self.img = [self getValueFromDict:Mydict Key:@"img"];
    self.detail = [self getValueFromDict:Mydict Key:@"detail"];
    
}

-(void)pushVC{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新消息" message:self.title preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self)
    UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"去看看" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [self vcPush];
    }];
    UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"下次" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancellAction];
    [alert addAction:OkAction];
    [[CTUtility getCurrentVC] presentViewController:alert animated:YES completion:nil];
}


-(void)vcPush{
    
    UINavigationController *nav = [CTUtility getCurrentVC].navigationController;
    
    if ((self.type != nil) && ([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"2"])){//曝光，正品优选详情
        ExposureDetailVC* expoDetailVC = [ExposureDetailVC new];
        expoDetailVC.urlStr = self.jumpurl;
        expoDetailVC.ThatID = self.ID;
        expoDetailVC.webtype = self.type;
        expoDetailVC.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:expoDetailVC animated:YES];
        return;
    }
    if ((self.type != nil) && [self.type isEqualToString:@"0"]){//商品详情
        ProductDetailVC* prodVC = [ProductDetailVC new];
        prodVC.ProductID = self.ID;
        prodVC.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:prodVC animated:YES];
        return;
    }
    
    WKwebVC* webVc = [[WKwebVC alloc] init];
    webVc.title = self.title;
    webVc.URLstr = self.jumpurl;
    webVc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:webVc animated:YES];
}

-(NSDictionary *)quaryGetWithUrlsStr:(NSString*)urlStr{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSArray *arr = [url.query componentsSeparatedByString:@"&"];
    [arr enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *array = [obj componentsSeparatedByString:@"="];
        [dict setObject:[array objectAtIndex:1] forKey:[array objectAtIndex:0]];
    }];
    return dict;
}

-(NSString *)getValueFromDict:(NSDictionary *)dict Key:(NSString*)key{

    NSString * str = [dict objectForKey:key];
    if (str==nil) {
        return @"";
    }
    return str;
}

@end
