//
//  UShareUI.m
//  ZPSY
//
//  Created by zhouhao on 2017/2/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "UShareView.h"
#import <UShareUI/UShareUI.h>



@interface UShareView(){

    NSArray *listArray;
    ShareViewModel*sharemodel;
}

@end


@implementation UShareView


-(instancetype)initWithModel:(ShareViewModel*)model{

    self=[super init];
    if (self) {
        sharemodel=model;
        [self viewinit];
    }
    return self;
}

-(void)viewinit{

    self.frame=kScreenBounds;
    self.layer.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3].CGColor;
    self.y=kScreenHeight;
    
    listArray=@[@{@"type":@(UMSocialPlatformType_WechatSession),
                  @"image":@"umsocial_wechat",
                  @"title":@"微信"
                  },
                @{@"type":@(UMSocialPlatformType_WechatTimeLine),
                  @"image":@"umsocial_wechat_timeline",
                  @"title":@"微信朋友圈"
                  },
                @{@"type":@(UMSocialPlatformType_QQ),
                  @"image":@"umsocial_qq",
                  @"title":@"QQ好友"
                  },
                @{@"type":@(UMSocialPlatformType_Qzone),
                  @"image":@"umsocial_qzone",
                  @"title":@"QQ空间"
                  },
                @{@"type":@(UMSocialPlatformType_Sina),
                  @"image":@"umsocial_sina",
                  @"title":@"新浪微博"
                  },
                ];
    
    NSInteger everyW=5;
    CGFloat w=kScreenWidth/everyW;
    
    CGFloat whiteHeight=w*ceilf(listArray.count/everyW*1.0);
    UIView *whiteView=[[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-whiteHeight-40, kScreenWidth, whiteHeight)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self addSubview:whiteView];
    
    [listArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger x=idx%everyW;
        NSInteger y=idx/everyW;
        UIButton *view=[[UIButton alloc] initWithFrame:CGRectMake(x*w, y*w, w, w)];
        [view addTarget:self action:@selector(btuSelectEvent:) forControlEvents:UIControlEventTouchUpInside];
        view.tag=idx;
        [whiteView addSubview:view];
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(w*0.15, 0, w*0.7, w*0.7)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.image=[UIImage imageNamed:obj[@"image"]];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, w*0.7, w, w*0.3)];
        lab.textColor = [UIColor blackColor];
        lab.font=[UIFont systemFontOfSize:kWidth_fit(13)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text=obj[@"title"];
        [view addSubview:image];
        [view addSubview:lab];
        
    }];
    
    
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteView.frame), kScreenWidth, 40)];
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(whiteView.frame)-80, kScreenWidth, 80)];
    bottomView.backgroundColor=[UIColor whiteColor];
    topview.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"分享";
    titleLab.textAlignment=NSTextAlignmentCenter;
    
    [topview addSubview:titleLab];
    [self addSubview:topview];
    [self addSubview:bottomView];

    
}

-(void)btuSelectEvent:(UIButton*)btn{
    
    UMSocialPlatformType platformType=[listArray[btn.tag][@"type"] integerValue];
    
    NSString* UMS_WebLink = sharemodel.UrlStr;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:sharemodel.Title descr:sharemodel.DesText thumImage:sharemodel.icon];
    //设置网页地址
    shareObject.webpageUrl = UMS_WebLink;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            BLOCK_SAFE(_shareresult)(error);
        }else{
            BLOCK_SAFE(_shareresult)(nil);
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
    
    
}
-(void)Show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.y=kScreenHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.y=0;
    }];
    
}
-(void)Hidden{
    [UIView animateWithDuration:0.3 animations:^{
        self.y=kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self Hidden];
}
@end
