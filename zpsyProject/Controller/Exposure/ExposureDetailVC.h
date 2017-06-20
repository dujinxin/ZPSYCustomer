//
//  ExposureDetailVC.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/27.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExposureDetailVC : UIViewController
@property (nonatomic,strong)NSString *webtype; //1-曝光；2-正品优选
@property (nonatomic,strong)NSString *ThatID;
@property (nonatomic,strong)NSString *urlStr;

@property (nonatomic,strong)NSString *detilStr;
@property (nonatomic,strong)NSString *imgStr;

@end
