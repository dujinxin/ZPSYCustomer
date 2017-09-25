//
//  BaseViewModel.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/21.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import Foundation

class BaseViewModel {
    let message = "参数或数据有误"
    
    /// <#Description#>
    var page : Int = 0
    /// <#Description#>
    var dataArray = [Any]()
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - param: <#param description#>
    ///   - completion: <#completion description#>
    func loadData(url:String, param:Dictionary<String,Any>?,completion:@escaping ((_ data:Any?, _ msg:String,_ isSuccess:Bool)->())) -> Void{
        
    }
}
