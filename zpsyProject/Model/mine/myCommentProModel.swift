//
//  myCommentProModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class myCommentProModel: NSObject {
    
    public var ID:String?
    public var createDateStr:String?
    public var content:String?
    public var praiseNum:String?
    public var resourcesId:String?
    public var type:String?
    public var updateDateStr:String?
    public var proModel:productModel?
    
    public var canPraise:Bool = false
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return[
            "ID":"id",
            "proModel":"ceccGoods"
        ]
    }
    
    
    
}
