//
//  SwiftHeader.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/15.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import Foundation


///SWIFT

let kScreenBounds = UIScreen.main.bounds

let kScreenSize  = kScreenBounds.size
let kScreenWidth:CGFloat = kScreenBounds.width
let kScreenHeight:CGFloat = kScreenBounds.height
let kWidth_iPhone6:CGFloat  =  375.0

/**
 *  比例（适配）
 */
var kScaleOfScreen:CGFloat = kScreenWidth/kWidth_iPhone6    //屏幕比例

let PlaceHoldeImageStr = "placeHoldeImage"
//颜色
//红色
let kColor_red = Utility.color(withHex: 0xc3222c)


enum scanProductType : NSInteger{
    case ScanTypeQuality ,//正品
    ScanTypeSuspicious ,//可疑品
    ScanTypeFakeStamp  //伪品
}
