//
//  LocationManager.m
//  ZPSY
//
//  Created by zhouhao on 2017/3/29.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationManager()<CLLocationManagerDelegate>{
    CLLocationManager* locationManager;
}

@end


@implementation LocationManager

-(instancetype)init{
   self= [super init];
    if (self) {
        [self viewinit];
    }
    return self;
}
-(void)viewinit{

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}
- (void)startLocation
{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    _longitute = [NSString stringWithFormat:@"%f",coordinate.longitude];
    _latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

-(NSString *)longitute{

    if (!_longitute) {
        return @"";
    }
    return _longitute;
}

-(NSString *)latitude{

    if (!_latitude) {
        return  @"";
    }
    return _latitude;
}

@end
