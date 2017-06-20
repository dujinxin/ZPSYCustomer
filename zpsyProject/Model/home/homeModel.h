//
//  homeModel.h
//  ZPSY
//
//  Created by zhouhao on 2017/3/7.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "youxuanModel.h"
#import "bannerModel.h"
@interface homeModel : NSObject<NSCoding>

@property(nonatomic,strong)NSMutableArray<bannerModel*> *banerListArr;
@property(nonatomic,strong)NSMutableArray<bannerModel*> *preferenceListArr;
@property(nonatomic,strong)NSMutableArray<bannerModel*> *adverListArr;

@end
