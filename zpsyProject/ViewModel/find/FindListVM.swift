//
//  FindListVM.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/21.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class FindListVM: BaseViewModel {

    override func loadData(url: String, param: Dictionary<String, Any>?, completion: @escaping ((Any?, String, Bool) -> ())) {
        JXRequest.request(url: url, param: param, success: { (data, msg) in
            
            guard
                let array = data as? Array<Dictionary<String, Any>>,
                let param = param,
                let page = param["pageNo"] as? Int
                else{
                    completion(nil, self.message, false)
                    return
            }
            
            if page == 1 {
                self.dataArray.removeAll()
            }
            for i in 0..<array.count{
                let model = FindEntity()
                model.mj_setKeyValues(array[i])
                //model.setValuesForKeys(array[i])
                self.dataArray.append(model)
            }
            
            completion(data, msg, true)
        }) { (msg, code) in
            
            completion(nil, msg, false)
        }
    }
}
