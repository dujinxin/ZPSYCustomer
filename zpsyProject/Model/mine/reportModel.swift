//
//  reportModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/26.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class reportModel: NSObject {

    public var answer:String?
    public var answertime:String?
    public var image1:String?
    public var contents:String?
    public var createDateStr:String?
    
    public var proModel:productModel?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return[
            "proModel":"ceccGoods"
        ]
    }
    
    public func answerRowGet() -> NSInteger {
        
        if self.answer == nil || self.answer == ""{
            return 0;
        }
        return 1
    }
    public func imageArrGet() -> NSArray {
        
        if self.image1 == nil || self.image1 == ""{
            return [];
        }
        let arr : [String] = (self.image1!.components(separatedBy: ","))
        return arr as NSArray
    }

}
