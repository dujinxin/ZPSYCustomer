//
//  UShareUI.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewModel.h"

//ShareViewModel *model=[[ShareViewModel alloc] init];
//model.UrlStr=@"https://www.baidu.com";
//model.Title=[CTUtility getAppName];
//model.DesText=@"描述内容";
//model.icon=[UIImage imageNamed:[CTUtility getAppIconName]];
//UShareView*share= [[UShareView alloc] initWithModel:model];
//[share Show];

@interface UShareView : UIView

-(instancetype)initWithModel:(ShareViewModel*)model;
@property(nonatomic,copy)void(^shareresult)(NSError*error);
-(void)Show;
-(void)Hidden;
@end
