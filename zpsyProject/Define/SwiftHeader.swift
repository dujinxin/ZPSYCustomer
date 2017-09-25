//
//  SwiftHeader.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/15.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import Foundation

/**
 *  比例（适配）
 */
var kScaleOfScreen:CGFloat = kScreenWidth/375.0    //屏幕比例

let PlaceHoldeImageStr = "placeHoldeImage"


enum scanProductType : NSInteger{
    case ScanTypeQuality ,//正品
    ScanTypeSuspicious ,//可疑品
    ScanTypeFakeStamp  //伪品
}
