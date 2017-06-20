//
//  ScanDetail1ViewController.h
//  ZPSY
//
//  Created by 杜进新 on 2017/5/27.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPSY-Swift.h"
#import "ScanGoodsInfoTableViewCell.h"
#import "GuiderViewFlowLayout.h"

@interface ScanDetailViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;
@property (nonatomic , strong) scanFinishModel * scanFinishModel;

@property (nonatomic , assign) ScanResultType myProductType;



@end
