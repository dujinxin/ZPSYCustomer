//
//  BaiduLocationManager.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/11/21.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class BaiduLocationManager : NSObject{
    
    static let manager = BaiduLocationManager()
    var mapManager : BMKMapManager
    var locationManager : BMKLocationService
    var geoManager : BMKGeoCodeSearch
    
    //经纬度 coordinate
    //latitude: CLLocationDegrees,
    //longitude: CLLocationDegrees
    var location : CLLocation?
    var reGeoComponent : BMKAddressComponent?
    var address : String?
    
    /// 是否开启或允许定位
    var isEnabled : Bool {
        return validate()
    }
    /// 是否正在定位&逆地理编码
    var isLoacating : Bool = false
    
    
    override init() {
        BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORDTYPE_BD09LL)
        self.mapManager = BMKMapManager()
        self.locationManager = BMKLocationService()
        
        self.geoManager = BMKGeoCodeSearch()
        
        
        super.init()
        
        self.mapManager.start(BaiduAppKey, generalDelegate: self)
    }
    func validate() -> Bool {
        if !CLLocationManager.locationServicesEnabled() {
            return false
        }
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
            return false
        }
        if CLLocationManager.authorizationStatus() == .notDetermined{
            let cllocationManager = CLLocationManager()
            cllocationManager.requestWhenInUseAuthorization()
        }
        return true
    }
    /// 持续定位
    func startUpdateLocation() {
        if !isEnabled {
            return
        }
        self.isLoacating =  true

        //设置delegate
        self.locationManager.delegate = self;
        //设置距离过滤参数
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //设置是否自动停止位置更新
        self.locationManager.pausesLocationUpdatesAutomatically = false;
        //设置是否允许后台定位
        self.locationManager.allowsBackgroundLocationUpdates = true;
        //        //设置位置获取超时时间
        //        self.locationManager.locationTimeout = 10;
        //        //设置获取地址信息超时时间
        //        self.locationManager.reGeocodeTimeout = 10;
        self.locationManager.startUserLocationService()
    }
    func stopUpdateLocation() {
        self.locationManager.stopUserLocationService()
        self.locationManager.delegate = nil
        self.isLoacating = false
    }
    func clearInfo() {
        self.location = nil
        self.reGeoComponent = nil
        self.geoManager.delegate = nil
    }
}
extension BaiduLocationManager : BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate {
    
    /**
     *返回网络错误
     *@param iError 错误号
     */
    func onGetNetworkState(_ iError: Int32) {
        print("定位网络码 \(iError)")
    }
    
    /**
     *返回授权验证错误
     *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
     */
    func onGetPermissionState(_ iError: Int32) {
        print("授权验证码 \(iError)")
    }
    

    /**
     *在将要启动定位时，会调用此函数
     */
    func willStartLocatingUser() {
        print("willStartLocatingUser")
    }
    
    /**
     *在停止定位后，会调用此函数
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }
    
    /**
     *用户方向更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        //print("didUpdateUserHeading \(userLocation)")
    }

    /**
     *用户位置更新后，会调用此函数
     *@param userLocation 新的用户位置
     */
    func didUpdate(_ userLocation: BMKUserLocation!) {
        print("didUpdate \(userLocation.location)")
        guard let loca = userLocation.location else{
            return
        }
        self.location = loca
        self.stopUpdateLocation()
        
        self.geoManager.delegate = self
        let option = BMKReverseGeoCodeOption()
        let coordinate2D = CLLocationCoordinate2D(latitude: loca.coordinate.latitude, longitude: loca.coordinate.longitude)
        
        option.reverseGeoPoint = coordinate2D
        
        self.geoManager.reverseGeoCode(option)
    }
    
    /**
     *定位失败后，会调用此函数
     *@param error 错误号
     */
    func didFailToLocateUserWithError(_ error: Error!) {
        print("didFailToLocateUserWithError \(error.localizedDescription)")
    }
    
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
        guard
            error == BMK_SEARCH_NO_ERROR ,
            let result = result,
            let address = result.address
        else {
            print("逆地理编码失败：\(error)")
            return
        }
        self.reGeoComponent = result.addressDetail
        self.address = address
        print("逆地理编码：",reGeoComponent?.country,address)
        //self.clearInfo()
    }
}
