//
//  UserManager.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import Foundation

private let userPath = NSHomeDirectory() + "/Documents/userAccound.json"

class UserManager : NSObject{
    
    static let manager = UserManager()
    
    //登录接口获取
    var userEntity = UserEntity()
    
//    var isLogin: Bool {
//        return !self.userEntity.token.isEmpty
//    }
    var isLogin: Bool {
        get {
            return !self.userEntity.token.isEmpty
        }
        set {
            self.isLogin = newValue
        }
    }
    
    
    override init() {
        super.init()
        
        let pathUrl = URL(fileURLWithPath: userPath)
        
        guard
            let data = try? Data(contentsOf: pathUrl),
            let dict = try? JSONSerialization.jsonObject(with: data, options: [])else {
                print("该地址不存在用户信息：\(userPath)")
                return
        }
        self.userEntity.setValuesForKeys(dict as! [String : Any])
        print("用户地址：\(userPath)")
        
    }
    
    /// 保存用户信息
    ///
    /// - Parameter dict: 用户信息字典
    /// - Returns: 保存结果
    func saveAccound(dict:Dictionary<String, Any>) -> Bool {
        
        self.userEntity.setValuesForKeys(dict)
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
            else {
                return false
        }
        try? data.write(to: URL.init(fileURLWithPath: userPath))
        print("保存地址：\(userPath)")
        
        return true
    }
    /// 删除用户信息
    func removeAccound() {
        self.userEntity = UserEntity()
        self.isLogin = false
        
        let fileManager = FileManager.default
        try? fileManager.removeItem(atPath: userPath)
    }
    
    
}
