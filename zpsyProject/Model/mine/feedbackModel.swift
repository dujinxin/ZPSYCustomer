//
//  feedbackModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/26.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedbackModel: NSObject {

    public var answer:String?
    public var atime:String?
    public var image:String?
    public var qtime:String?
    public var question:String?
    
    
    public func answerRowGet() -> NSInteger {
        
        if self.answer == nil || self.answer == ""{
            return 0;
        }
        return 1
    }
    public func imageArrGet() -> NSArray {
        
        if self.image == nil || self.image == ""{
            return [];
        }
        let arr : [String] = (self.image?.components(separatedBy: ","))!
        return arr as NSArray
    }
    
    
}
