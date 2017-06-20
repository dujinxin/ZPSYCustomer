//
//  FdbackAndReportShowPicCell.h
//  ZPSY
//
//  Created by zhouhao on 2017/2/27.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KevenPicEditAndShowView.h"
@interface FdbackAndReportShowPicCell : UITableViewCell
@property(nonatomic,strong)UILabel *mainlab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timelab;
@property(nonatomic,strong)KevenPicEditAndShowView*PicShowView;
@end
