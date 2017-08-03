//
//  scanFinishModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/29.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit
//点赞人
class UserPraiseModel: NSObject {
    public var ID:String?
    public var nickName:String?
    public var avatar:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return[
            "ID":"id"
        ]
    }

}
//批次
class GoodsLotBatchModel: NSObject {
    public var date:String?
    public var event:String?
}
class GoodsFlowModel: NSObject {
    public var process:String?
    public var list_batchField:NSArray? = []
}
class GoodsFlowSubModel: NSObject {
    public var file:String?
    public var contents:String?
    public var location:String?
    public var Operator:String?
    public var operationTime:String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return [
            "Operator":"operator"
        ]
    }
}

//扫码地点、时间、手机型号
class ScanrecordForSuspectProductModel: NSObject {
    public var scanTime:String?
    public var city:String?
    public var model:String?
}
//新增码状态
//goodsStatus 如果goodsStatus中的status为1则继续读取其他的数据,如果不为1 则中断,然后读取goodsStatus中的describe内容显示在客户端
//status 状态 1 正常  2 未绑定 3 停用 4 废弃
class scanFinishModel: NSObject {

    //商品详情
    public var proDetailModel:productDetailModel?    //点赞人
    public var userPraiseArr:NSMutableArray? = NSMutableArray.init()
    //旧批次(韩国)
    public var goodsLotBatchArr:NSMutableArray? = NSMutableArray.init()
    //新批次
    public var goodsFlowArr:NSMutableArray? = NSMutableArray.init()
    public var goodsFlowShortArr :NSMutableArray? = NSMutableArray.init()
    //扫码地点、时间、手机型号
    public var scanrecordForSuspectProductArr:NSMutableArray? = NSMutableArray.init()
    
    public var quality:String?
    
    public var codeSnId:String?
    
    public var qualificate:String?
    
    
    public func setmodel(scandict:NSDictionary){
        
        self.proDetailModel = productDetailModel.mj_object(withKeyValues: scandict["ceccGoods"])
        self.quality = (scandict["ceccGoods"] as! NSDictionary)["quality"] as? String
        self.userPraiseArr = UserPraiseModel.mj_objectArray(withKeyValuesArray: (scandict["ceccGoods"]as! NSDictionary)["list_user"])
        self.goodsLotBatchArr = GoodsLotBatchModel.mj_objectArray(withKeyValuesArray: scandict["list_ceccGoodsLotBatch"])
        //self.goodsFlowArr = GoodsFlowModel.mj_objectArray(withKeyValuesArray: scandict["list_batch"])
        self.scanrecordForSuspectProductArr = ScanrecordForSuspectProductModel.mj_objectArray(withKeyValuesArray: scandict["list_ceccScanrecordForSuspectProduct"])
        
        if let station = scandict["station"] as? Dictionary<String,String>,
            let qualificate1 = station["qualificate"],
            qualificate1.isEmpty == false{
            qualificate = qualificate1
        }
        
        let arr = scandict["list_batch"] as? NSArray  ?? []
        
        var count = 1
        
        for i in 0..<arr.count {
            let dict = arr[i] as! NSDictionary
            let model = GoodsFlowModel.init()
            model.process = dict.object(forKey: "process") as? String;
            
            let subArr = dict.object(forKey: "list_batchField") as! NSArray
            
            let dataArr = NSMutableArray.init()
            let dataShortArr = NSMutableArray.init(capacity: 3)
            
            for j in 0..<subArr.count {
                
                let dict = subArr[j] as! NSDictionary
                
                guard let model = GoodsFlowSubModel.mj_object(withKeyValues: dict) else {
                    return
                }
                
                if count <= 3 {
                    dataShortArr.add(model)
                    count += 1
                }
                dataArr.add(model)
            }
            
            if dataShortArr.count > 0{
                model.list_batchField = NSMutableArray.init(array: dataShortArr)
                self.goodsFlowShortArr?.add(model)
            }
            model.list_batchField = NSMutableArray.init(array: dataArr)
            self.goodsFlowArr?.add(model)
        }
    }
    
}
