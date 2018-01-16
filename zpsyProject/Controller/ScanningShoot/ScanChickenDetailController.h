//
//  ScanChickenDetailController.h
//  ZPSY
//
//  Created by 杜进新 on 2018/1/16.
//  Copyright © 2018年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPSY-Swift.h"
#import "ScanGoodsInfoTableViewCell.h"
#import "GuiderViewFlowLayout.h"

@interface ScanChickenDetailController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic , strong) scanFinishModel * scanFinishModel;

@property (nonatomic , assign) ScanResultType myProductType;



@end
