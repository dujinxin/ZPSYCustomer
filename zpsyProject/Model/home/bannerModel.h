//
//  bannerModel.h
//  ZPSY
//
//  Created by zhouhao on 2017/3/23.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bannerModel : NSObject<NSCoding>
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *sortImage;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *field3;//跳转类型
@property(nonatomic,strong)NSString *jumpUrl;
@property(nonatomic,strong)NSString *field4;//首页专用ID
@end
