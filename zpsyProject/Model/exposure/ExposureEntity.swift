//
//  ExposureEntity.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/21.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class FindEntity: BaseModel {
    
    public var ID:String?
    //public var exposureBarid:String?//收藏时的曝光ID 废弃
    //public var preferenceId:String? //收藏时的正品优选ID 废弃
    public var title:String?
    public var thumbnail:String?
    public var summary:String?
    public var hazardClass:String?
    public var hazardClassimg:String?
    public var source:String?
    public var sourceUrl:String?
    public var jumpUrl:String?
    public var field3:String?
    public var detail:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return [
            "ID":"id"
        ]
    }
    
    
}
