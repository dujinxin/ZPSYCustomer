//
//  messageModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class messageModel: NSObject {
    public var isNewRecord:Bool?
    public var ID:String?
    public var type:String?
    public var title:String?
    public var imagethum:String?//小图
    public var time:String?
    public var field1:String?//大图
    public var url:String?
    public var contents:String?
    public var field3:String?//跳转类型
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return [
            "ID":"id"
        ]
    }
}
