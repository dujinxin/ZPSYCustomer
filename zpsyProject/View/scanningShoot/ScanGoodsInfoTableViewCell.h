//
//  ScanGoodsInfoTableViewCell.h
//  ZPSY
//
//  Created by 杜进新 on 2017/5/25.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanGoodsEntity.h"
#import "AdScrollView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

typedef void(^ClickBlock)(BOOL isOpen,NSInteger index);

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
@property (nonatomic, strong) UIImageView * resultImageView;
@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * resultButton;

@property (nonatomic, strong) UIButton * reportButton;
@property (nonatomic, strong) UIButton * detailButton;

@property (nonatomic, assign) ScanResultType type;

@property (nonatomic, strong) ScanGoodsEntity * entity;

@end

@interface TitleView : UIView

@property (nonatomic, strong) UIImageView * arrow;
@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, assign, getter=isOpen) BOOL open;
@property (nonatomic, copy) ClickBlock block;

@end


@interface ScanGoodsInfoView : UIView

@property (nonatomic, strong) AdScrollView * scrollView;

@property (nonatomic, strong) UIImageView * leftImage;
@property (nonatomic, strong) UIImageView * centerImage;
@property (nonatomic, strong) UIImageView * rightImage;

@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, assign) CGFloat   imageHeight;

@property (nonatomic, copy) ClickBlock block;
@end

@interface ExtraView : UIView

@property (nonatomic, strong) UIImageView * productImage;
@property (nonatomic, copy) ClickBlock  block;
@property (nonatomic, strong) ScanGoodsEntity * entity;


@end
