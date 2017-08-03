//
//  bannerModel.h
//  ZPSY
//
//  Created by zhouhao on 2017/3/23.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeEntity : NSObject<NSCoding>

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *type;//0：商品，1: 曝光栏，2：正品优选
@property(nonatomic,strong)NSString *status;//0表示无过期时间  1表示有过期时间
@property(nonatomic,strong)NSString *jumpUrl;

@property(nonatomic,strong)NSString *expirationDate;
@property(nonatomic,strong)NSString *createDate;
@property(nonatomic,strong)NSString *updateDate;
@property(nonatomic,strong)NSString *createDateStr;
@property(nonatomic,strong)NSString *updateDateStr;

@end

@interface bannerEntity : HomeEntity

@property(nonatomic,strong)NSString *resourcesId;

@end

@interface ExposureEntity : HomeEntity
//exposurebar
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,strong)NSString *sortImage;
@property(nonatomic,strong)NSString *thumbnail;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *sourceUrl;
@property(nonatomic,strong)NSString *sourceImg;

@property(nonatomic,strong)NSString *shortTitle;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *hazardClass;
@property(nonatomic,strong)NSString *hazardClassimg;
@property(nonatomic,strong)NSString *commentsNum;
@property(nonatomic,strong)NSString *isFrontPage;
@property(nonatomic,strong)NSString *isBanner;
@property(nonatomic,strong)NSString *banner_status;

@end
