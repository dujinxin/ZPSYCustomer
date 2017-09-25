//
//  UserEntity.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class UserEntity: BaseModel {

    var nickName : String = ""     //昵称
    var avatar : String?           //头像
    var messageNum : Int = 0       //消息
    var score : Int = 0            //积分
    var genuid : String = ""       //正品号
    var feedbackNum : Int = 0      //反馈
    var collectionNum : Int = 0    //收藏
    var mobile : String = ""       //手机号
    var token : String = ""        //token

}
