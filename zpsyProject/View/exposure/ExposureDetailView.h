//
//  ExposureDetailView.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface ExposureDetailView : UIView
@property(nonatomic, strong)NSString *HtmlStr;  //加载html
@property(nonatomic, strong)NSString *UrlStr;   //加载Url
@property(nonatomic, strong)NSString *Filepath; //加载文件


@property(nonatomic, copy)void(^enventDoBlock)(NSString*);

@end
