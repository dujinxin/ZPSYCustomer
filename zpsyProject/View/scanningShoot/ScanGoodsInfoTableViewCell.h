//
//  ScanGoodsInfoTableViewCell.h
//  ZPSY
//
//  Created by 杜进新 on 2017/5/25.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanGoodsEntity.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

typedef NS_ENUM(NSInteger,ScanResultType){
    Quality,//正品
    Forge,  //伪品
    Doubt   //疑品
};

@interface ScanGoodsView : UIView

@property (nonatomic, strong) UIImageView * goodsImage;
@property (nonatomic, strong) UILabel * goodsName;
@property (nonatomic, strong) UILabel * productCanpanyName;
@property (nonatomic, strong) UILabel * productCode;

@property (nonatomic, strong) UIButton * comparePriseButton;

@property (nonatomic, assign) ScanResultType  type;


@end


@interface AuthResultView : UIView

@property (nonatomic, strong) UIImageView * bgImage;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * resultButton;
@property (nonatomic, strong) UILabel * infoLabel;

@property (nonatomic, strong) UIButton * reportButton;
@property (nonatomic, strong) UIButton * detailButton;

@property (nonatomic, assign) ScanResultType type;

@property (nonatomic, strong) ScanGoodsEntity * entity;


@end

typedef void(^ClickBlock)(BOOL isOpen,NSInteger index);

@interface TitleView : UIView

@property (nonatomic, strong) UIImageView * arrow;
@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, assign, getter=isOpen) BOOL open;
@property (nonatomic, copy) ClickBlock block;

@end


@interface ScanGoodsInfoView : UIView

@property (nonatomic, strong) UIImageView * productImage;

@property (nonatomic, strong) UILabel * infolabel1;
@property (nonatomic, strong) UILabel * infolabel2;
@property (nonatomic, strong) UILabel * infolabel3;
@property (nonatomic, strong) UILabel * infolabel4;
@property (nonatomic, strong) UILabel * infolabel5;

@property (nonatomic, strong) UILabel * productAddress;
@property (nonatomic, strong) UIImageView * packageType;
@property (nonatomic, strong) UILabel * packageStandard;
@property (nonatomic, strong) UILabel * weight;
@property (nonatomic, strong) UILabel * ingredient;

@property (nonatomic, strong) ScanGoodsEntity * entity;


@end

@interface ExtraView : UIView

@property (nonatomic, strong) UIImageView * productImage;
@property (nonatomic, copy) ClickBlock  block;
@property (nonatomic, strong) ScanGoodsEntity * entity;


@end
