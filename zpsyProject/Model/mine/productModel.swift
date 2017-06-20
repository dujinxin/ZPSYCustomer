//
//  productModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class productModel: NSObject {
    public var ID:String?
    public var goodsImg:NSString?
    public var thumbnail:NSString?
    //public var goodsId:NSString? 废弃
    public var createDateStr:NSString?
    public var name:NSString?
    public var goodsName:NSString? //历史中用
    
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
    
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return[
            "ID":"id"
        ]
    }
    
    
}
