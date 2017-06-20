//
//  LocationManager.h
//  ZPSY
//
//  Created by zhouhao on 2017/3/29.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject
- (void)startLocation;


@property(nonatomic,strong)NSString *longitute;//纬度
@property(nonatomic,strong)NSString *latitude;//经度


@end
