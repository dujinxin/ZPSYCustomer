//
//  ScanFlowTableViewCell.h
//  ZPSY
//
//  Created by 杜进新 on 2017/5/26.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPSY-Swift.h"

typedef void(^ImageViewClickBlock)(NSInteger index);

@interface ScanFlowCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UILabel * infoLabel;

@property (nonatomic, strong) UIImageView * firstImageView;
@property (nonatomic, strong) UIImageView * secondImageView;
@property (nonatomic, strong) UIImageView * thirdImageView;

@property (nonatomic, copy) ImageViewClickBlock   block;

@property (nonatomic, strong) GoodsFlowSubModel * model;

@end

//韩国版
@interface ScanFlowOldCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UIView * point;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * infoLabel;

@property (nonatomic, strong) GoodsLotBatchModel * model;

@property (nonatomic, assign) CGFloat  height;

@end

@interface ScanFlowCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UIView * point;
@property (nonatomic, strong) UILabel * titleLabel;

@end
