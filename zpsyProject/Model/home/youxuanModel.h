//
//  bannerModel.h
//  ZPSY
//
//  Created by zhouhao on 2017/3/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface youxuanModel : NSObject<NSCoding>

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *shortTitle;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *sourceUrl;
@property(nonatomic,strong)NSString *jumpUrl;
@property(nonatomic,strong)NSString *contents;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *thumbnail;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *field4;//首页专用ID
@property(nonatomic,strong)NSString *detail;
@end
