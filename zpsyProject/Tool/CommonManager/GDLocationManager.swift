//
//  GDLocationManager.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/19.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class GDLocationManager : NSObject{
    
    static let manager = GDLocationManager()
    
    var locationManager : AMapLocationManager
    //经纬度 coordinate
    //latitude: CLLocationDegrees, 
    //longitude: CLLocationDegrees
    var location : CLLocation?
    
    /*逆地理编码信息
     *
     *{ formattedAddress:北京市丰台区南四环西路靠近汉威国际广场3区;
                 country:中国;
                province:北京市; 
                    city:北京市; 
                district:丰台区; 
                citycode:010; 
                  adcode:110106;
                  street:南四环西路; 
                  number:122号; 
                 POIName:汉威国际广场3区; 
                 AOIName:汉威国际广场3区;}
     */
    var reGeocode : AMapLocationReGeocode?
    
    /// 是否开启或允许定位
    var isEnabled : Bool {
        return validate()
    }
    /// 是否正在定位&逆地理编码
    var isLoacating : Bool = false
    
    
    override init() {
        AMapServices.shared().apiKey = GDAppKey
        
        self.locationManager = AMapLocationManager()
        
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
    /// 单次定位
    func startLocation() {
        
        if !isEnabled {
            return
        }
        self.isLoacating =  true
        
        // 带逆地理信息的一次定位（返回坐标和地址信息
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //   定位超时时间，最低2s，此处设置为2s
        self.locationManager.locationTimeout = 2
        //   逆地理请求超时时间，最低2s，此处设置为2s
        self.locationManager.reGeocodeTimeout = 2
        
        self.locationManager.requestLocation(withReGeocode: false) { [weak self] (location, reGeoCode, error) in
            if let error = error {
                //错误处理
                print("error",error.localizedDescription)
                
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                }
            }
            if let location = location {
                //获取定位经纬度
                print("location",location)
                self?.location = location
            }
            if let reGeoCode = reGeoCode {
                //获取逆地理编码信息
                print("reGeoCode",reGeoCode)
            }
            self?.clearInfo()
        }
    }
    /// 持续定位
    func startUpdateLocation() {
        if !isEnabled {
            return
        }
        self.isLoacating =  true
        
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 200
        self.locationManager.locatingWithReGeocode = true
        
        //系统语言为英文时返回中文编码//zh-Hans-CN
        
//        UserDefaults.standard.set(["en-US"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        let languages = UserDefaults.standard.object(forKey: "AppleLanguages")
//        print("languages ",languages)
        
        self.locationManager.startUpdatingLocation()
    }
    func stopUpdateLocation() {
        
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    func clearInfo() {
        self.isLoacating = false
        self.location = nil
        self.reGeocode = nil
    }
}
extension GDLocationManager : AMapLocationManagerDelegate {
    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        print("CLAuthorizationStatus:",status)
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        print("didFailWithError:",error.localizedDescription)
        self.stopUpdateLocation()
        //location <+39.82397434,+116.29456136> +/- 165.00m (speed -1.00 mps / course -1.00) @ 2017/9/19 中国标准时间 17:47:46
    }
    //实现了下边的方法，则这个方法不会调用
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        print("location:",location)
        self.location = location
        self.stopUpdateLocation()
    }
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        print("location:",location,"reGeocode",reGeocode)
        
        if
            let location = location,
            self.locationManager.locatingWithReGeocode == false{
            
            self.isLoacating = false
            self.location = location
            self.stopUpdateLocation()
        }
        if
            let reGeocode = reGeocode ,
            self.locationManager.locatingWithReGeocode == true{
            
            self.isLoacating = false
            self.location = location
            self.reGeocode = reGeocode
            self.stopUpdateLocation()
            
            //系统语言为英文时返回中文编码//zh-Hans-CN
//            UserDefaults.standard.set(["zh-Hans-CN"], forKey: "AppleLanguages")
//            UserDefaults.standard.synchronize()
//            let languages = UserDefaults.standard.object(forKey: "AppleLanguages")
//            print("languages ",languages)
        }
        
    }
}
