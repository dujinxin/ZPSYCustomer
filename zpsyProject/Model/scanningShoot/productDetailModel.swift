//
//  productDetailModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/29.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class productDetailModel: NSObject {

    
    public var ID:String?
    public var attention:String?
    public var category:String?
    public var certificateFile:String?//认证证书
    public var createDateStr:String?
    public var favoritesNum:String?
    public var goodsImg:String?
    public var ingredients:String?
    public var manufacturer:String?
    public var name:String?
    public var ownershipFile:String?
    public var packingType:String?
    public var provenance:String?
    public var packingSpec:String?
    public var weight:String?
    public var officeName:String?
    public var thumbnail:String?
    public var praiseNum:String?
    public var jumpUrl:String?
    public var remarks:String?
    public var isFavorites:String?
    
    public var code:String?
    
    //new
    public var regNo:String?
    public var reportFile:String? //检测报告
    public var list_batch:NSArray? = []
    
    public var list_ceccGoodsField:NSArray?=[]
    
    public func getfirstGoodImg() -> String {
        
        let arr = self.getArrGoodsImg()
        if arr.count==0 {
            return ""
        }
        return arr[0] as! String
    }
    
    public func getArrGoodsImg() ->NSArray {
        var arr:[String]
        let Str = self.goodsImg
        if Str == nil{
            return [];
        }
        arr = (Str?.components(separatedBy: ","))!
        return arr as NSArray
    }
    
    public func getProperty(key:String)->String{
    
        let propertyStr = self.value(forKey: key)
        if propertyStr == nil {
            return ""
        }
        return propertyStr as! String
    }
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return[
            "ID":"id"
        ]
    }
    
}
